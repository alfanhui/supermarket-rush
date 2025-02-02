﻿using UnityEngine;
using System.Collections;
/*
 * This Script was taken from http://www.unitygeek.com/unity_c_singleton/
 * 
 * Copyright © unitygeek.com 
 * 
 * */


public class Singleton<T> : MonoBehaviour where T : Singleton<T> {

    private static T instance;

    public static T Instance {
        get {
            if (instance == null) {
                instance = FindObjectOfType<T>();
                if (instance == null) {
                    GameObject obj = new GameObject();
                    obj.name = typeof(T).Name;
                    instance = obj.AddComponent<T>();
                }
            }
            return instance;
        }
    }

    public virtual void Awake() {
        if (instance == null) {
            instance = this as T;
            //DontDestroyOnLoad(this.gameObject);
        }
        else {
            Destroy(gameObject);
        }
    }


} 
