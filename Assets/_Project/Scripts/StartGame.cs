using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.Characters.FirstPerson;

public class StartGame : MonoBehaviour
{
	public FirstPersonController firstPersonController;
	public GameObject UIObject;
	public GameObject playViewCamera;
	public GameObject mainCamera;

    public void OnUIButtonClick()
	{
		playViewCamera.SetActive(false);
		mainCamera.SetActive(true);

		firstPersonController.enabled = true;
		UIObject.SetActive(false);
	}
}
