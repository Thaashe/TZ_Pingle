using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.Characters.FirstPerson;
using UnityEngine.Playables;


public class DemoScene : MonoBehaviour
{
	public FirstPersonController firstPersonController;
	public GameObject UIObject;

	public PlayableDirector playableDirector;
	public GameObject cinemachineTimeline;
	
	public void OnUIButtonClick()
	{
		UIObject.SetActive(false);
		playableDirector.stopped += OnPlayableDirectorStopped;
		cinemachineTimeline.SetActive(true);
		playableDirector.Play();
	}

	void OnPlayableDirectorStopped(PlayableDirector aDirector)
	{
		UIObject.SetActive(true);
		cinemachineTimeline.SetActive(false);
	}
}
