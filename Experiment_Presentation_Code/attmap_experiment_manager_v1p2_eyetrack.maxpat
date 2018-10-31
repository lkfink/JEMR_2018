{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 5,
			"minor" : 1,
			"revision" : 9
		}
,
		"rect" : [ 164.0, 45.0, 1080.0, 722.0 ],
		"bglocked" : 0,
		"defrect" : [ 164.0, 45.0, 1080.0, 722.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r to_python",
					"fontsize" : 12.0,
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 369.0, 257.0, 71.0, 20.0 ],
					"id" : "obj-37"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "print",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial",
					"patching_rect" : [ 452.0, 321.0, 34.0, 20.0 ],
					"id" : "obj-31"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Send messages to Python",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial",
					"patching_rect" : [ 293.0, 219.0, 150.0, 20.0 ],
					"id" : "obj-25"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 295.0, 254.0, 20.0, 20.0 ],
					"id" : "obj-5"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "host and port numbers must match the values in the python script",
					"linecount" : 2,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial",
					"patching_rect" : [ 296.0, 350.0, 255.0, 34.0 ],
					"id" : "obj-6"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "int", "bang" ],
					"fontname" : "Arial",
					"patching_rect" : [ 295.0, 286.0, 50.0, 20.0 ],
					"id" : "obj-19"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "udpsend 127.0.0.1 44102",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial",
					"patching_rect" : [ 295.0, 321.0, 147.0, 20.0 ],
					"id" : "obj-20"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "START",
					"fontface" : 1,
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"presentation_rect" : [ 455.625, 179.0, 51.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 298.0, 118.0, 51.0, 18.0 ],
					"presentation" : 1,
					"id" : "obj-12"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "STOP",
					"fontface" : 1,
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"presentation_rect" : [ 553.625, 179.0, 42.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 378.0, 118.0, 43.0, 18.0 ],
					"presentation" : 1,
					"id" : "obj-7"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b 0.25 b",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "bang", "float", "bang" ],
					"fontname" : "Arial",
					"patching_rect" : [ 36.0, 366.0, 61.0, 20.0 ],
					"id" : "obj-30"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s std_amp_lvl",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"color" : [ 1.0, 0.0, 1.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 36.0, 424.5, 84.0, 20.0 ],
					"id" : "obj-21"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s lb",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"color" : [ 1.0, 0.0, 1.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 36.0, 392.5, 29.0, 20.0 ],
					"id" : "obj-2"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"fontname" : "Arial",
					"patching_rect" : [ 36.0, 337.5, 60.0, 20.0 ],
					"id" : "obj-11"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Manage Files and Paths",
					"fontface" : 1,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"presentation_rect" : [ 149.5, 238.0, 147.0, 20.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 575.5, 375.0, 149.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-69"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p manage_files_paths",
					"fontsize" : 12.0,
					"numinlets" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 159.0, 261.0, 128.0, 20.0 ],
					"color" : [ 1.0, 0.5, 0.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 586.0, 401.0, 128.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-68",
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 5,
							"minor" : 1,
							"revision" : 9
						}
,
						"rect" : [ 425.0, 45.0, 515.0, 407.0 ],
						"bglocked" : 0,
						"defrect" : [ 425.0, 45.0, 515.0, 407.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 1,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend text",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 130.5, 341.5, 77.0, 20.0 ],
									"id" : "obj-45"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "textbutton",
									"align" : 0,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"text" : "Macintosh HD:/Users/laurenfink/Documents/3_Quarter/Experiment/Data/",
									"numoutlets" : 3,
									"presentation_rect" : [ 36.0, 295.0, 432.0, 50.0 ],
									"bgcolor" : [ 0.849681, 0.849681, 0.849681, 1.0 ],
									"outlettype" : [ "", "", "int" ],
									"bgoncolor" : [ 0.6, 0.6, 0.6, 1.0 ],
									"fontname" : "Arial",
									"ignoreclick" : 1,
									"patching_rect" : [ 130.5, 369.0, 100.0, 20.0 ],
									"truncate" : 0,
									"presentation" : 1,
									"id" : "obj-46"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r lb",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 12.0, 265.0, 27.0, 20.0 ],
									"id" : "obj-48"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s data_path",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 12.0, 347.5, 73.0, 20.0 ],
									"id" : "obj-51"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 116.0, 256.0, 20.0, 20.0 ],
									"id" : "obj-52"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "Change path",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"presentation_rect" : [ 383.0, 268.0, 85.0, 18.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 141.0, 256.0, 79.0, 18.0 ],
									"presentation" : 1,
									"id" : "obj-53"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "\"Macintosh HD:/Users/laurenfink/Documents/3_Quarter/Experiment/Data/\"",
									"linecount" : 3,
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"bgcolor2" : [ 0.950103, 0.950103, 0.950103, 1.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 12.0, 310.5, 215.0, 46.0 ],
									"id" : "obj-54"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "opendialog fold",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 116.0, 279.0, 92.0, 20.0 ],
									"id" : "obj-55"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Data File Path",
									"fontface" : 1,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"presentation_rect" : [ 36.0, 267.0, 162.0, 20.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.0, 229.0, 162.0, 20.0 ],
									"presentation" : 1,
									"id" : "obj-56"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend text",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 400.0, 167.0, 77.0, 20.0 ],
									"id" : "obj-41"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "textbutton",
									"align" : 0,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"text" : "Macintosh HD:/Users/laurenfink/Documents/3_Quarter/Experiment/stims/",
									"numoutlets" : 3,
									"presentation_rect" : [ 36.0, 194.5, 432.0, 50.0 ],
									"bgcolor" : [ 0.849681, 0.849681, 0.849681, 1.0 ],
									"outlettype" : [ "", "", "int" ],
									"bgoncolor" : [ 0.6, 0.6, 0.6, 1.0 ],
									"fontname" : "Arial",
									"ignoreclick" : 1,
									"patching_rect" : [ 400.0, 194.5, 100.0, 20.0 ],
									"truncate" : 0,
									"presentation" : 1,
									"id" : "obj-43"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend text",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 134.0, 155.0, 77.0, 20.0 ],
									"id" : "obj-39"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "textbutton",
									"align" : 0,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"text" : "Macintosh HD:/Users/laurenfink/Documents/3_Quarter/Experiment/attmap_params_v1p2.xml",
									"numoutlets" : 3,
									"presentation_rect" : [ 36.0, 96.5, 432.0, 50.0 ],
									"bgcolor" : [ 0.849681, 0.849681, 0.849681, 1.0 ],
									"outlettype" : [ "", "", "int" ],
									"bgoncolor" : [ 0.6, 0.6, 0.6, 1.0 ],
									"fontname" : "Arial",
									"ignoreclick" : 1,
									"patching_rect" : [ 134.0, 182.5, 100.0, 20.0 ],
									"truncate" : 0,
									"presentation" : 1,
									"id" : "obj-36"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r lb",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 278.0, 51.0, 27.0, 20.0 ],
									"id" : "obj-20"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s stim_dir",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 278.0, 172.5, 62.0, 20.0 ],
									"id" : "obj-21"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 382.0, 42.0, 20.0, 20.0 ],
									"id" : "obj-24"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "Change folder",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"presentation_rect" : [ 383.0, 169.0, 85.0, 18.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 407.0, 42.0, 86.0, 18.0 ],
									"presentation" : 1,
									"id" : "obj-30"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "\"Macintosh HD:/Users/laurenfink/Documents/3_Quarter/Experiment/stims/\"",
									"linecount" : 3,
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"bgcolor2" : [ 0.950103, 0.950103, 0.950103, 1.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 278.0, 96.5, 215.0, 46.0 ],
									"id" : "obj-31"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "opendialog fold",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 382.0, 65.0, 92.0, 20.0 ],
									"id" : "obj-32"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Stimulus File Directory",
									"fontface" : 1,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"presentation_rect" : [ 36.0, 167.0, 162.0, 20.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 281.0, 15.0, 162.0, 20.0 ],
									"presentation" : 1,
									"id" : "obj-19"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r lb",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.0, 54.0, 27.0, 20.0 ],
									"id" : "obj-50"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s params_fname",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.0, 164.0, 100.0, 20.0 ],
									"id" : "obj-47"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 129.0, 45.0, 20.0, 20.0 ],
									"id" : "obj-44"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "Change file",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"presentation_rect" : [ 397.0, 71.5, 71.0, 18.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 154.0, 45.0, 75.0, 18.0 ],
									"presentation" : 1,
									"id" : "obj-42"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "\"Macintosh HD:/Users/laurenfink/Documents/3_Quarter/Experiment/attmap_params_v1p2.xml\"",
									"linecount" : 4,
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"bgcolor2" : [ 0.950103, 0.950103, 0.950103, 1.0 ],
									"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.0, 99.5, 227.0, 60.0 ],
									"id" : "obj-40"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "opendialog",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 129.0, 68.0, 69.0, 20.0 ],
									"id" : "obj-37"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Parameter Presets File",
									"fontface" : 1,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"presentation_rect" : [ 36.0, 69.5, 157.0, 20.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.0, 15.0, 145.0, 20.0 ],
									"presentation" : 1,
									"id" : "obj-7"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-55", 0 ],
									"destination" : [ "obj-54", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-55", 0 ],
									"destination" : [ "obj-54", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-54", 0 ],
									"destination" : [ "obj-51", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-54", 0 ],
									"destination" : [ "obj-45", 0 ],
									"hidden" : 0,
									"midpoints" : [ 21.5, 334.5, 140.0, 334.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-53", 0 ],
									"destination" : [ "obj-52", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-52", 0 ],
									"destination" : [ "obj-55", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-50", 0 ],
									"destination" : [ "obj-40", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-48", 0 ],
									"destination" : [ "obj-54", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-45", 0 ],
									"destination" : [ "obj-46", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-44", 0 ],
									"destination" : [ "obj-37", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-42", 0 ],
									"destination" : [ "obj-44", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-41", 0 ],
									"destination" : [ "obj-43", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-40", 0 ],
									"destination" : [ "obj-47", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-40", 0 ],
									"destination" : [ "obj-39", 0 ],
									"hidden" : 0,
									"midpoints" : [ 24.5, 149.25, 143.5, 149.25 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-39", 0 ],
									"destination" : [ "obj-36", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-37", 0 ],
									"destination" : [ "obj-40", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-37", 0 ],
									"destination" : [ "obj-40", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-32", 0 ],
									"destination" : [ "obj-31", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-32", 0 ],
									"destination" : [ "obj-31", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-31", 0 ],
									"destination" : [ "obj-41", 0 ],
									"hidden" : 0,
									"midpoints" : [ 287.5, 160.75, 409.5, 160.75 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-31", 0 ],
									"destination" : [ "obj-21", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-30", 0 ],
									"destination" : [ "obj-24", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-24", 0 ],
									"destination" : [ "obj-32", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-20", 0 ],
									"destination" : [ "obj-31", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"globalpatchername" : "",
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "(double click)",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"presentation_rect" : [ 160.5, 199.0, 83.75, 20.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 45.5, 289.0, 85.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-66"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r trial_num",
					"fontsize" : 12.0,
					"numinlets" : 0,
					"numoutlets" : 1,
					"color" : [ 0.0, 1.0, 1.0, 1.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 353.0, 573.5, 67.0, 20.0 ],
					"id" : "obj-35"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "r run_num",
					"fontsize" : 12.0,
					"numinlets" : 0,
					"numoutlets" : 1,
					"color" : [ 0.0, 1.0, 1.0, 1.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 279.5, 573.5, 65.0, 20.0 ],
					"id" : "obj-33"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "0:00:02",
					"fontsize" : 14.0,
					"numinlets" : 2,
					"gradient" : 1,
					"numoutlets" : 1,
					"presentation_rect" : [ 492.625, 264.0, 66.0, 21.0 ],
					"bgcolor2" : [ 0.571429, 0.532969, 0.432724, 1.0 ],
					"bgcolor" : [ 0.113725, 0.105882, 0.086275, 1.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Helvetica Neue Light",
					"ignoreclick" : 1,
					"patching_rect" : [ 436.0, 598.5, 63.0, 21.0 ],
					"presentation" : 1,
					"id" : "obj-80",
					"textcolor" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p stopwatch",
					"fontsize" : 12.0,
					"numinlets" : 0,
					"numoutlets" : 1,
					"color" : [ 1.0, 0.5, 0.0, 1.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 430.0, 573.5, 75.0, 20.0 ],
					"id" : "obj-79",
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 5,
							"minor" : 1,
							"revision" : 9
						}
,
						"rect" : [ 575.0, 100.0, 309.0, 459.0 ],
						"bglocked" : 0,
						"defrect" : [ 575.0, 100.0, 309.0, 459.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r exp_stop",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 192.0, 70.0, 67.0, 20.0 ],
									"id" : "obj-2"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "0",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 37.0, 99.5, 32.5, 18.0 ],
									"id" : "obj-39"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r lb",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 37.0, 70.0, 27.0, 20.0 ],
									"id" : "obj-35"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "hh:mm:ss",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 154.5, 398.5, 66.0, 20.0 ],
									"id" : "obj-34"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 116.0, 396.0, 25.0, 25.0 ],
									"id" : "obj-32",
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "% 60",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 178.0, 283.0, 38.0, 20.0 ],
									"id" : "obj-31"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "% 60",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 240.0, 217.0, 38.0, 20.0 ],
									"id" : "obj-30"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Display duration (hh:mm:ss) since experiment start ",
									"fontface" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 11.0, 12.0, 285.0, 20.0 ],
									"id" : "obj-13"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "min to hr",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 11.0, 283.0, 67.0, 20.0 ],
									"id" : "obj-29"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "sec to min",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 11.0, 217.0, 67.0, 20.0 ],
									"id" : "obj-28"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "ms to sec",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 11.0, 158.0, 67.0, 20.0 ],
									"id" : "obj-27"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "/ 60",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 116.0, 283.0, 32.5, 20.0 ],
									"id" : "obj-25"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "/ 60",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 116.0, 217.0, 32.5, 20.0 ],
									"id" : "obj-24"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sprintf %i:%02i:%02i",
									"fontsize" : 12.0,
									"numinlets" : 3,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Verdana",
									"patching_rect" : [ 116.0, 339.0, 143.0, 21.0 ],
									"id" : "obj-15"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "stop",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 192.0, 99.5, 33.0, 18.0 ],
									"id" : "obj-18"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "/ 1000",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 116.0, 158.0, 44.0, 20.0 ],
									"id" : "obj-14"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 116.0, 99.5, 20.0, 20.0 ],
									"id" : "obj-12"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "clocker 1000",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "float" ],
									"fontname" : "Arial",
									"patching_rect" : [ 116.0, 131.0, 79.0, 20.0 ],
									"id" : "obj-8"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r exp_start",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 116.0, 70.0, 67.0, 20.0 ],
									"id" : "obj-1"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-14", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-39", 0 ],
									"destination" : [ "obj-14", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-35", 0 ],
									"destination" : [ "obj-39", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-31", 0 ],
									"destination" : [ "obj-15", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-30", 0 ],
									"destination" : [ "obj-15", 2 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 0 ],
									"destination" : [ "obj-15", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-24", 0 ],
									"destination" : [ "obj-31", 0 ],
									"hidden" : 0,
									"midpoints" : [ 125.5, 249.5, 187.5, 249.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-24", 0 ],
									"destination" : [ "obj-25", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-18", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-18", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-15", 0 ],
									"destination" : [ "obj-32", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-14", 0 ],
									"destination" : [ "obj-30", 0 ],
									"hidden" : 0,
									"midpoints" : [ 125.5, 197.0, 249.5, 197.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-14", 0 ],
									"destination" : [ "obj-24", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-12", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"globalpatchername" : "",
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Elapsed Time",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"presentation_rect" : [ 483.125, 238.0, 85.0, 20.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 426.5, 548.5, 82.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-77"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Iteration",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial",
					"patching_rect" : [ 353.0, 548.5, 52.0, 20.0 ],
					"id" : "obj-75"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "int", "bang" ],
					"fontname" : "Arial",
					"patching_rect" : [ 353.0, 598.5, 50.0, 20.0 ],
					"id" : "obj-76"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Progress indicators",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial",
					"patching_rect" : [ 321.5, 521.5, 115.0, 20.0 ],
					"id" : "obj-74"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Run",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"presentation_rect" : [ 350.0, 238.0, 32.0, 20.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 288.0, 548.5, 33.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-72"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"presentation_rect" : [ 341.0, 264.0, 50.0, 20.0 ],
					"outlettype" : [ "int", "bang" ],
					"fontname" : "Arial",
					"patching_rect" : [ 279.5, 598.5, 50.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-70"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "attmap experiment manager",
					"fontsize" : 30.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"presentation_rect" : [ 151.0, 94.0, 438.0, 36.0 ],
					"bgcolor" : [ 0.890097, 0.890097, 0.890097, 1.0 ],
					"fontname" : "Helvetica",
					"patching_rect" : [ 171.5, 20.5, 393.0, 36.0 ],
					"presentation" : 1,
					"id" : "obj-67"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s open_aud_status",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"color" : [ 1.0, 0.0, 1.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 298.0, 468.0, 112.0, 20.0 ],
					"id" : "obj-65"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "open",
					"fontsize" : 12.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"presentation_rect" : [ 346.375, 337.0, 35.0, 18.0 ],
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 298.0, 445.0, 37.0, 18.0 ],
					"presentation" : 1,
					"id" : "obj-63"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Audio Status",
					"fontface" : 1,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"presentation_rect" : [ 320.5, 313.0, 91.0, 20.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 298.0, 415.0, 94.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-60"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route text",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 35.0, 170.0, 61.0, 20.0 ],
					"id" : "obj-61"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Subject Interface",
					"fontface" : 1,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"presentation_rect" : [ 149.5, 152.0, 107.0, 20.0 ],
					"bgcolor" : [ 1.0, 1.0, 1.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 35.0, 241.0, 106.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-34"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p subj_interface",
					"fontsize" : 12.0,
					"numinlets" : 0,
					"numoutlets" : 0,
					"presentation_rect" : [ 154.5, 178.0, 97.0, 20.0 ],
					"color" : [ 1.0, 0.5, 0.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 39.5, 265.0, 97.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-17",
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 5,
							"minor" : 1,
							"revision" : 9
						}
,
						"rect" : [ -35.0, 54.0, 1086.0, 616.0 ],
						"bgcolor" : [ 0.537255, 0.537255, 0.537255, 1.0 ],
						"bglocked" : 0,
						"defrect" : [ -35.0, 54.0, 1086.0, 616.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 1,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"visible" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b b 77",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 432.0, 51.0, 20.0 ],
									"id" : "obj-17"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s to_python",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 490.0, 457.0, 73.0, 20.0 ],
									"id" : "obj-35"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "delay 100",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 524.0, 154.0, 63.0, 20.0 ],
									"id" : "obj-7"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "route 1 2",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 203.0, 58.0, 20.0 ],
									"id" : "obj-25"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "1",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 179.0, 32.5, 18.0 ],
									"id" : "obj-23"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "2",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 524.0, 179.0, 32.5, 18.0 ],
									"id" : "obj-21"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r exp_stop",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 524.0, 130.0, 67.0, 20.0 ],
									"id" : "obj-11"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "\"Please notify the experimenter that you have finished this portion of the experiment and wait for further instructions.\"",
									"linecount" : 3,
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 524.0, 229.0, 261.0, 46.0 ],
									"id" : "obj-3"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "+",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 236.0, 471.0, 32.5, 18.0 ],
									"id" : "obj-4"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "start run via space bar input, but only at experiment start or end of runs",
									"linecount" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 242.0, 17.0, 325.0, 34.0 ],
									"id" : "obj-24"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "1",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 353.5, 371.0, 32.5, 18.0 ],
									"id" : "obj-22"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t 0 b",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "int", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 371.0, 34.0, 20.0 ],
									"id" : "obj-20"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "gate",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 403.0, 34.0, 20.0 ],
									"id" : "obj-16"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s start_run",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 411.0, 468.0, 67.0, 20.0 ],
									"id" : "obj-15"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "select 32",
									"fontsize" : 13.0,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 341.0, 64.0, 21.0 ],
									"id" : "obj-8"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "keyup",
									"fontsize" : 13.0,
									"numinlets" : 0,
									"numoutlets" : 4,
									"outlettype" : [ "int", "int", "int", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 312.0, 59.5, 21.0 ],
									"id" : "obj-18"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r end_run",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 151.0, 62.0, 20.0 ],
									"id" : "obj-14"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "\"Feel free to take a short break. Then, press the space bar for the next run.\"",
									"linecount" : 4,
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 229.0, 118.0, 60.0 ],
									"id" : "obj-13"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "\"Press the space bar to start.\"",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 98.0, 169.0, 18.0 ],
									"id" : "obj-10"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend text",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 242.0, 118.0, 77.0, 20.0 ],
									"id" : "obj-5"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "loadmess \"Please wait for instructions.\"",
									"linecount" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 242.0, 69.0, 126.0, 34.0 ],
									"id" : "obj-2"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r exp_start",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 395.0, 69.0, 67.0, 20.0 ],
									"id" : "obj-1"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "textbutton",
									"fontsize" : 48.0,
									"numinlets" : 1,
									"bgovercolor" : [ 0.537255, 0.537255, 0.537255, 1.0 ],
									"text" : "Please notify the experimenter that you have finished this portion of the experiment and wait for further instructions.",
									"numoutlets" : 3,
									"bgoveroncolor" : [ 0.537255, 0.537255, 0.537255, 1.0 ],
									"presentation_rect" : [ 643.0, 389.0, 673.0, 308.0 ],
									"bgcolor" : [ 0.537255, 0.537255, 0.537255, 1.0 ],
									"outlettype" : [ "", "", "int" ],
									"bgoncolor" : [ 0.537255, 0.537255, 0.537255, 1.0 ],
									"bordercolor" : [ 0.537255, 0.537255, 0.537255, 1.0 ],
									"fontname" : "Arial",
									"ignoreclick" : 1,
									"patching_rect" : [ 242.0, 151.0, 108.0, 46.0 ],
									"truncate" : 0,
									"presentation" : 1,
									"id" : "obj-6"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-20", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-21", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-4", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [ 245.5, 499.0, 210.5, 499.0, 210.5, 115.0, 251.5, 115.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [ 533.5, 298.0, 363.5, 298.0, 363.5, 113.0, 251.5, 113.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 1 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 0 ],
									"destination" : [ "obj-13", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-23", 0 ],
									"destination" : [ "obj-25", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-22", 0 ],
									"destination" : [ "obj-16", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-21", 0 ],
									"destination" : [ "obj-25", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-20", 0 ],
									"destination" : [ "obj-16", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-20", 1 ],
									"destination" : [ "obj-16", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-18", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-14", 0 ],
									"destination" : [ "obj-23", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-14", 0 ],
									"destination" : [ "obj-22", 0 ],
									"hidden" : 0,
									"midpoints" : [ 404.5, 176.0, 363.0, 176.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-13", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [ 404.5, 299.0, 360.0, 299.0, 360.0, 115.0, 251.5, 115.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-11", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-22", 0 ],
									"hidden" : 0,
									"midpoints" : [ 404.5, 89.0, 380.0, 89.0, 380.0, 357.0, 363.0, 357.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-17", 2 ],
									"destination" : [ "obj-35", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-16", 0 ],
									"destination" : [ "obj-17", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-17", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [ 404.5, 459.0, 245.5, 459.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-17", 1 ],
									"destination" : [ "obj-15", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"globalpatchername" : "",
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Set standard (linear) amplitude level",
					"linecount" : 2,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"fontname" : "Arial",
					"patching_rect" : [ 36.0, 444.5, 121.0, 34.0 ],
					"id" : "obj-22"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "*Start/Stop Experiment",
					"fontface" : 1,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"presentation_rect" : [ 455.625, 152.0, 140.0, 20.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 298.0, 91.0, 140.0, 20.0 ],
					"presentation" : 1,
					"id" : "obj-49"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Play stimulus loop, select probe times, present deviants, collect response, write data to file",
					"linecount" : 3,
					"fontface" : 2,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 575.0, 170.0, 181.0, 48.0 ],
					"id" : "obj-4"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p manage_trial",
					"fontsize" : 12.0,
					"numinlets" : 0,
					"numoutlets" : 0,
					"color" : [ 1.0, 0.5, 0.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 575.0, 220.5, 90.0, 20.0 ],
					"id" : "obj-3",
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 5,
							"minor" : 1,
							"revision" : 9
						}
,
						"rect" : [ 784.0, 108.0, 506.0, 580.0 ],
						"bglocked" : 0,
						"defrect" : [ 784.0, 108.0, 506.0, 580.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"visible" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "p write_data_file",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.5, 0.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 18.0, 453.0, 98.0, 20.0 ],
									"id" : "obj-9",
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 5,
											"minor" : 1,
											"revision" : 9
										}
,
										"rect" : [ 202.0, 130.0, 1278.0, 518.0 ],
										"bglocked" : 0,
										"defrect" : [ 202.0, 130.0, 1278.0, 518.0 ],
										"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 0,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 0,
										"toolbarvisible" : 1,
										"boxanimatetime" : 200,
										"imprint" : 0,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"boxes" : [ 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r run_num",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 406.573059, 164.0, 61.0, 19.0 ],
													"id" : "obj-36"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "estimated thresh given trial resp",
													"linecount" : 3,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 655.510803, 117.0, 79.5, 44.0 ],
													"id" : "obj-35"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t i i",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 571.531555, 197.0, 32.5, 19.0 ],
													"id" : "obj-33"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "NOTE: de-logging deviant level for reporting dB value",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 610.260803, 341.0, 170.0, 32.0 ],
													"id" : "obj-18"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t 10 f",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 654.010803, 265.0, 35.0, 19.0 ],
													"id" : "obj-51"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "pow",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 654.010803, 291.0, 35.0, 19.0 ],
													"id" : "obj-20"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r sub_resp",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 983.927795, 164.0, 62.0, 19.0 ],
													"id" : "obj-17"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "zl nth",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 654.010803, 241.0, 37.0, 19.0 ],
													"id" : "obj-16"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r obs_num",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 571.531555, 164.0, 62.0, 19.0 ],
													"id" : "obj-11"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "Initiate subject data CSV file upon experiment start. \nWrite trial data to file each time probe is tested.",
													"linecount" : 2,
													"fontface" : 2,
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 17.0, 15.0, 292.0, 34.0 ],
													"id" : "obj-9"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r probe_cond",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 901.448547, 164.0, 75.0, 19.0 ],
													"id" : "obj-2"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "tosymbol @separator \\,",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 17.0, 171.0, 122.0, 19.0 ],
													"id" : "obj-62"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t s",
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 129.5, 320.0, 23.0, 20.0 ],
													"id" : "obj-52"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "prepend set",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 241.614624, 265.0, 69.0, 19.0 ],
													"id" : "obj-50"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r probe_time",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 818.969299, 164.0, 72.0, 19.0 ],
													"id" : "obj-49"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "Format trial data for csv file",
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 591.51062, 70.0, 283.0, 20.0 ],
													"id" : "obj-48"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "Write to file when banged",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 29.0, 263.0, 78.0, 32.0 ],
													"id" : "obj-47"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t b l clear",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "bang", "", "clear" ],
													"fontname" : "Arial",
													"patching_rect" : [ 17.0, 197.0, 55.0, 19.0 ],
													"id" : "obj-46"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "Create header when patch loaded",
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 17.0, 70.0, 196.0, 20.0 ],
													"id" : "obj-45"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "subject_id stim_name run_num trial_num obs_num mean_pdf converged probe_time probe_cond sub_resp",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 17.0, 124.0, 284.0, 30.0 ],
													"id" : "obj-42"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r lb",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 17.0, 95.0, 26.0, 19.0 ],
													"id" : "obj-41"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "zl reg",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 654.010803, 207.0, 37.0, 19.0 ],
													"id" : "obj-37"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t cr l",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "cr", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 488.614624, 393.0, 31.0, 19.0 ],
													"id" : "obj-31"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "sprintf symout %s\\,%s\\,%d\\,%d\\,%d\\,%.03f\\,%d\\,%d\\,%s\\,%d",
													"fontsize" : 11.0,
													"numinlets" : 10,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 241.614624, 347.0, 304.0, 19.0 ],
													"id" : "obj-15"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t b b b i",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "bang", "bang", "bang", "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 727.531372, 197.0, 59.5, 19.0 ],
													"id" : "obj-14"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "prepend set",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 324.093811, 265.0, 69.0, 19.0 ],
													"id" : "obj-8"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "pack s s i i i f i i s i",
													"fontsize" : 11.0,
													"numinlets" : 10,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 241.614563, 320.0, 761.313232, 19.0 ],
													"id" : "obj-7"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r trial_num",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 489.052368, 164.0, 62.0, 19.0 ],
													"id" : "obj-6"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r conv_indicator",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 727.531372, 164.0, 87.0, 19.0 ],
													"id" : "obj-5"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r mean_pdf",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 655.510803, 164.0, 66.0, 19.0 ],
													"id" : "obj-4"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r stim_name",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 324.093811, 164.0, 71.0, 19.0 ],
													"id" : "obj-3"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "prepend write",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 17.0, 373.0, 77.0, 19.0 ],
													"id" : "obj-24"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r subjid",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 241.614624, 164.0, 46.0, 19.0 ],
													"id" : "obj-23"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "zl reg",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 17.0, 320.0, 37.0, 19.0 ],
													"id" : "obj-19"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "sprintf symout %sattmap_v1p2_lauren_%s.csv",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ -2.0, 346.0, 239.0, 19.0 ],
													"id" : "obj-13"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r data_path",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 35.0, 294.0, 66.0, 19.0 ],
													"id" : "obj-12"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "text",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "", "bang", "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 488.614624, 427.0, 43.0, 19.0 ],
													"id" : "obj-1"
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"source" : [ "obj-13", 0 ],
													"destination" : [ "obj-24", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-19", 0 ],
													"destination" : [ "obj-13", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-52", 0 ],
													"destination" : [ "obj-13", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-8", 0 ],
													"destination" : [ "obj-7", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-7", 0 ],
													"destination" : [ "obj-15", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-62", 0 ],
													"destination" : [ "obj-46", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-6", 0 ],
													"destination" : [ "obj-7", 3 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-51", 0 ],
													"destination" : [ "obj-20", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-51", 1 ],
													"destination" : [ "obj-20", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-50", 0 ],
													"destination" : [ "obj-7", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-5", 0 ],
													"destination" : [ "obj-14", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-49", 0 ],
													"destination" : [ "obj-7", 7 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-46", 1 ],
													"destination" : [ "obj-31", 0 ],
													"hidden" : 0,
													"midpoints" : [ 44.5, 243.0, 233.0, 243.0, 233.0, 384.0, 498.114624, 384.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-46", 0 ],
													"destination" : [ "obj-19", 0 ],
													"hidden" : 0,
													"midpoints" : [ 26.5, 226.0, 26.5, 226.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-46", 2 ],
													"destination" : [ "obj-1", 0 ],
													"hidden" : 0,
													"midpoints" : [ 62.5, 245.0, 232.0, 245.0, 232.0, 420.0, 498.114624, 420.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-42", 0 ],
													"destination" : [ "obj-62", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-41", 0 ],
													"destination" : [ "obj-42", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-4", 0 ],
													"destination" : [ "obj-37", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-37", 0 ],
													"destination" : [ "obj-16", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-36", 0 ],
													"destination" : [ "obj-7", 2 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-33", 0 ],
													"destination" : [ "obj-7", 4 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-33", 1 ],
													"destination" : [ "obj-16", 1 ],
													"hidden" : 0,
													"midpoints" : [ 594.531555, 228.0, 681.510803, 228.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-31", 0 ],
													"destination" : [ "obj-1", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-31", 1 ],
													"destination" : [ "obj-1", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-3", 0 ],
													"destination" : [ "obj-8", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-24", 0 ],
													"destination" : [ "obj-1", 0 ],
													"hidden" : 0,
													"midpoints" : [ 26.5, 420.0, 498.114624, 420.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-23", 0 ],
													"destination" : [ "obj-52", 0 ],
													"hidden" : 0,
													"midpoints" : [ 251.114624, 193.0, 139.0, 193.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-23", 0 ],
													"destination" : [ "obj-50", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-20", 0 ],
													"destination" : [ "obj-7", 5 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-2", 0 ],
													"destination" : [ "obj-7", 8 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-17", 0 ],
													"destination" : [ "obj-7", 9 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-16", 0 ],
													"destination" : [ "obj-51", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-15", 0 ],
													"destination" : [ "obj-31", 0 ],
													"hidden" : 0,
													"midpoints" : [ 251.114624, 379.0, 498.114624, 379.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-14", 1 ],
													"destination" : [ "obj-7", 0 ],
													"hidden" : 0,
													"midpoints" : [ 750.531372, 291.0, 251.114563, 291.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-14", 3 ],
													"destination" : [ "obj-7", 6 ],
													"hidden" : 0,
													"midpoints" : [ 777.531372, 289.0, 745.990051, 289.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-14", 2 ],
													"destination" : [ "obj-37", 0 ],
													"hidden" : 0,
													"midpoints" : [ 764.031372, 233.0, 712.281372, 233.0, 712.281372, 202.0, 663.510803, 202.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-14", 0 ],
													"destination" : [ "obj-19", 0 ],
													"hidden" : 0,
													"midpoints" : [ 737.031372, 252.5, 26.5, 252.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-12", 0 ],
													"destination" : [ "obj-19", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-11", 0 ],
													"destination" : [ "obj-33", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
 ]
									}
,
									"saved_object_attributes" : 									{
										"fontface" : 0,
										"globalpatchername" : "",
										"fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"fontname" : "Arial",
										"default_fontsize" : 12.0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "p collect_trial_resp",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.5, 0.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 18.0, 369.0, 111.0, 20.0 ],
									"id" : "obj-8",
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 5,
											"minor" : 1,
											"revision" : 9
										}
,
										"rect" : [ 18.0, 166.0, 512.0, 460.0 ],
										"bglocked" : 0,
										"defrect" : [ 18.0, 166.0, 512.0, 460.0 ],
										"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 0,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 0,
										"toolbarvisible" : 1,
										"boxanimatetime" : 200,
										"imprint" : 0,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"boxes" : [ 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "misses = 5; hits = 6\nsend to python",
													"linecount" : 2,
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 232.0, 250.0, 150.0, 34.0 ],
													"id" : "obj-20"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "s to_python",
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 230.0, 323.0, 73.0, 20.0 ],
													"id" : "obj-35"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "+ 5",
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 231.0, 291.0, 32.5, 20.0 ],
													"id" : "obj-3"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t i i",
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 129.5, 257.0, 32.5, 20.0 ],
													"id" : "obj-1"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "0",
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 56.0, 267.0, 32.5, 18.0 ],
													"id" : "obj-2"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "bangbang",
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 261.0, 123.0, 64.0, 20.0 ],
													"id" : "obj-34"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "s sub_resp",
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"color" : [ 1.0, 0.0, 1.0, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 129.5, 301.0, 69.0, 20.0 ],
													"id" : "obj-33"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "0",
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 261.0, 149.0, 32.5, 18.0 ],
													"id" : "obj-32"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "During response period, accept space bar press as a hit and close gate. If no hit by end of response period, register a miss and close gate.\nNote: for trial_resp, 0 = miss, 1 = hit.",
													"linecount" : 3,
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 11.0, 4.0, 397.0, 48.0 ],
													"id" : "obj-23"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "0",
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 131.5, 94.0, 32.5, 18.0 ],
													"id" : "obj-19"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t i i",
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 131.5, 123.0, 34.0, 20.0 ],
													"id" : "obj-16"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "1",
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 11.0, 94.0, 32.5, 18.0 ],
													"id" : "obj-15"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "1",
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 306.0, 149.0, 32.5, 18.0 ],
													"id" : "obj-12"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "gate",
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 131.5, 215.0, 34.0, 20.0 ],
													"id" : "obj-10"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r end_resp_period",
													"fontsize" : 12.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 131.5, 65.0, 108.0, 20.0 ],
													"id" : "obj-6"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r start_resp_period",
													"fontsize" : 12.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 11.0, 65.0, 111.0, 20.0 ],
													"id" : "obj-5"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "select 32",
													"fontsize" : 13.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 261.0, 94.0, 64.0, 21.0 ],
													"id" : "obj-8"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "keyup",
													"fontsize" : 13.0,
													"numinlets" : 0,
													"numoutlets" : 4,
													"outlettype" : [ "int", "int", "int", "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 261.0, 65.0, 59.5, 21.0 ],
													"id" : "obj-18"
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"source" : [ "obj-8", 0 ],
													"destination" : [ "obj-34", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-6", 0 ],
													"destination" : [ "obj-19", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-5", 0 ],
													"destination" : [ "obj-15", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-34", 0 ],
													"destination" : [ "obj-32", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-34", 1 ],
													"destination" : [ "obj-12", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-32", 0 ],
													"destination" : [ "obj-10", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-19", 0 ],
													"destination" : [ "obj-16", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-18", 0 ],
													"destination" : [ "obj-8", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-16", 0 ],
													"destination" : [ "obj-10", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-16", 1 ],
													"destination" : [ "obj-10", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-15", 0 ],
													"destination" : [ "obj-10", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-12", 0 ],
													"destination" : [ "obj-10", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-10", 0 ],
													"destination" : [ "obj-2", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-3", 0 ],
													"destination" : [ "obj-35", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-10", 0 ],
													"destination" : [ "obj-1", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-1", 0 ],
													"destination" : [ "obj-33", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-1", 1 ],
													"destination" : [ "obj-3", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
 ]
									}
,
									"saved_object_attributes" : 									{
										"fontface" : 0,
										"globalpatchername" : "",
										"fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"fontname" : "Arial",
										"default_fontsize" : 12.0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "p stim_loop_player",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.5, 0.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 18.0, 273.0, 111.0, 20.0 ],
									"id" : "obj-6",
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 5,
											"minor" : 1,
											"revision" : 9
										}
,
										"rect" : [ 626.0, 57.0, 581.0, 685.0 ],
										"bglocked" : 0,
										"defrect" : [ 626.0, 57.0, 581.0, 685.0 ],
										"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 0,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 0,
										"toolbarvisible" : 1,
										"boxanimatetime" : 200,
										"imprint" : 0,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"boxes" : [ 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "startwindow",
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 19.0, 583.0, 74.0, 18.0 ],
													"id" : "obj-43"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "1",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 261.0, 185.0, 32.5, 17.0 ],
													"id" : "obj-52"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 261.0, 206.0, 20.0, 20.0 ],
													"id" : "obj-51"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "dac~",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 4.0, 642.0, 35.0, 19.0 ],
													"id" : "obj-5"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r lb",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 261.0, 159.0, 26.0, 19.0 ],
													"id" : "obj-20"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "loop $1",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 261.0, 230.0, 47.0, 17.0 ],
													"id" : "obj-2"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r lb",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 100.0, 196.0, 26.0, 19.0 ],
													"id" : "obj-13"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r exp_stop",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 128.0, 145.0, 62.0, 19.0 ],
													"id" : "obj-15"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r open_aud_status",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 55.5, 604.5, 102.0, 19.0 ],
													"id" : "obj-49"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r lb",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 19.0, 558.0, 26.0, 19.0 ],
													"id" : "obj-7"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "p control_target_pres",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"color" : [ 1.0, 0.5, 0.0, 1.0 ],
													"outlettype" : [ "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 162.75, 459.5, 114.0, 19.0 ],
													"id" : "obj-11",
													"patcher" : 													{
														"fileversion" : 1,
														"appversion" : 														{
															"major" : 5,
															"minor" : 1,
															"revision" : 9
														}
,
														"rect" : [ 62.0, 175.0, 823.0, 619.0 ],
														"bglocked" : 0,
														"defrect" : [ 62.0, 175.0, 823.0, 619.0 ],
														"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
														"openinpresentation" : 0,
														"default_fontsize" : 12.0,
														"default_fontface" : 0,
														"default_fontname" : "Arial",
														"gridonopen" : 0,
														"gridsize" : [ 15.0, 15.0 ],
														"gridsnaponopen" : 0,
														"toolbarvisible" : 1,
														"boxanimatetime" : 200,
														"imprint" : 0,
														"enablehscroll" : 1,
														"enablevscroll" : 1,
														"devicewidth" : 0.0,
														"boxes" : [ 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "s to_python",
																	"fontsize" : 12.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 537.0, 570.0, 73.0, 20.0 ],
																	"id" : "obj-35"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "zl reg",
																	"fontsize" : 12.0,
																	"numinlets" : 2,
																	"numoutlets" : 2,
																	"outlettype" : [ "", "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 537.0, 542.0, 40.0, 20.0 ],
																	"id" : "obj-12"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "t b b",
																	"fontsize" : 12.0,
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "bang", "bang" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 449.0, 512.0, 34.0, 20.0 ],
																	"id" : "obj-10"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "r probe_time",
																	"fontsize" : 12.0,
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 558.0, 503.0, 78.0, 20.0 ],
																	"id" : "obj-6"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "message",
																	"text" : "0.",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 615.0, 442.5, 33.0, 17.0 ],
																	"id" : "obj-22"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "t b b",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "bang", "bang" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 530.0, 369.5, 32.5, 19.0 ],
																	"id" : "obj-19"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "onebang",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 2,
																	"outlettype" : [ "bang", "bang" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 615.0, 416.5, 53.0, 19.0 ],
																	"id" : "obj-17"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "t i i",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "int", "int" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 171.25, 453.0, 32.0, 19.0 ],
																	"id" : "obj-14"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "button",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "bang" ],
																	"patching_rect" : [ 451.5, 543.0, 20.0, 20.0 ],
																	"id" : "obj-11"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "button",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "bang" ],
																	"patching_rect" : [ 602.5, 218.0, 20.0, 20.0 ],
																	"id" : "obj-41"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "float",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "float" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 602.5, 254.0, 31.0, 19.0 ],
																	"id" : "obj-31"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "- 10.",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "float" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 602.5, 281.0, 33.0, 19.0 ],
																	"id" : "obj-18"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "loop duration",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 592.0, 21.0, 74.0, 19.0 ],
																	"id" : "obj-8"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "audio signal",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 507.5, 21.0, 70.0, 19.0 ],
																	"id" : "obj-7"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "float" ],
																	"patching_rect" : [ 616.5, 47.0, 25.0, 25.0 ],
																	"id" : "obj-3",
																	"comment" : ""
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "If probe time is 0 (i.e., start of loop), start 10 ms ramp at final 10 ms of loop.\n\nHave to replace edge value with (nondetectable) value 0.0 after first time 0 detected so it doesn't bang off on following probe trial",
																	"linecount" : 7,
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 611.0, 319.5, 205.0, 95.0 ],
																	"id" : "obj-20"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "route 0.",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "", "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 649.0, 190.0, 75.0, 19.0 ],
																	"id" : "obj-4"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "t b b 0",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 3,
																	"outlettype" : [ "bang", "bang", "int" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 424.5, 143.0, 43.0, 19.0 ],
																	"id" : "obj-9"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "s probe_applied",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"color" : [ 1.0, 0.0, 1.0, 1.0 ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 171.25, 526.0, 89.0, 19.0 ],
																	"id" : "obj-103"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "if $i1 == 1 then bang",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 171.25, 495.0, 111.0, 19.0 ],
																	"id" : "obj-102"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "view transition probs in Max window",
																	"linecount" : 2,
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 8.0, 404.5, 112.0, 32.0 ],
																	"id" : "obj-101"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "message",
																	"text" : "dump",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 8.0, 439.5, 38.0, 17.0 ],
																	"id" : "obj-99"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "after 4th trial, open gate (ie., apply AM probe) on 85 % of trials",
																	"linecount" : 2,
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 159.625, 178.5, 178.0, 32.0 ],
																	"id" : "obj-83"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "r end_trial",
																	"fontsize" : 11.0,
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"color" : [ 0.0, 1.0, 1.0, 1.0 ],
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 171.25, 216.0, 59.0, 19.0 ],
																	"id" : "obj-81"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "r trial_num",
																	"fontsize" : 11.0,
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"color" : [ 0.0, 1.0, 1.0, 1.0 ],
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 250.25, 216.0, 62.0, 19.0 ],
																	"id" : "obj-80"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "onebang",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 2,
																	"outlettype" : [ "bang", "bang" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 171.25, 277.0, 91.0, 19.0 ],
																	"id" : "obj-79"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "if $i1 >= 4 then bang",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 250.25, 246.0, 111.0, 19.0 ],
																	"id" : "obj-78"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "number",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "int", "bang" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 171.25, 427.0, 50.0, 19.0 ],
																	"id" : "obj-77"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "message",
																	"text" : "clear",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 222.75, 368.0, 34.0, 17.0 ],
																	"id" : "obj-76"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "r end_run",
																	"fontsize" : 11.0,
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"color" : [ 0.0, 1.0, 1.0, 1.0 ],
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 222.75, 343.0, 58.0, 19.0 ],
																	"id" : "obj-74"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "r lb",
																	"fontsize" : 11.0,
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"color" : [ 0.0, 1.0, 1.0, 1.0 ],
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 8.0, 292.0, 26.0, 19.0 ],
																	"id" : "obj-73"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "message",
																	"text" : "1 0 100, 1 1 0",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 71.0, 370.0, 78.0, 17.0 ],
																	"id" : "obj-64"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "message",
																	"text" : "0 1 85, 0 0 15",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 47.25, 342.0, 78.0, 17.0 ],
																	"id" : "obj-58"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "button",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "bang" ],
																	"patching_rect" : [ 171.25, 348.0, 20.0, 20.0 ],
																	"id" : "obj-44"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "prob",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "int", "bang" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 171.25, 400.0, 33.0, 19.0 ],
																	"id" : "obj-39",
																	"save" : [ "#N", "prob", ";" ]
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "close gate and repopulate weights at at start of run",
																	"linecount" : 2,
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 386.0, 83.0, 142.0, 32.0 ],
																	"id" : "obj-33"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "r start_run",
																	"fontsize" : 11.0,
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"color" : [ 0.0, 1.0, 1.0, 1.0 ],
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 424.5, 116.0, 61.0, 19.0 ],
																	"id" : "obj-29"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "Applies weighted transition probabilities to enforce the following rules in selecting trials for AM target presentation:\n\n1. Trial # must be > 4\n2. After each \"standard\" (non-target) trial, 85% chance that next trial will contain a target.\n3. Each test trial followed by standard trial.",
																	"linecount" : 8,
																	"fontsize" : 12.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 8.75, 12.0, 305.0, 117.0 ],
																	"id" : "obj-28"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "gate",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 448.5, 484.0, 32.0, 19.0 ],
																	"id" : "obj-5"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "edge~",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "bang", "bang" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 530.0, 342.0, 42.0, 19.0 ],
																	"id" : "obj-108"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "Apply transient AM at probe time",
																	"linecount" : 2,
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 649.0, 122.0, 106.0, 32.0 ],
																	"id" : "obj-96"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "r probe_time",
																	"fontsize" : 11.0,
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"color" : [ 0.0, 1.0, 1.0, 1.0 ],
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 649.0, 155.0, 73.0, 19.0 ],
																	"id" : "obj-94"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : ">=~",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "signal" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 530.0, 316.0, 32.0, 19.0 ],
																	"id" : "obj-93"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "signal" ],
																	"patching_rect" : [ 530.0, 47.0, 25.0, 25.0 ],
																	"id" : "obj-2",
																	"comment" : ""
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "outlet",
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"patching_rect" : [ 451.5, 574.5, 25.0, 25.0 ],
																	"id" : "obj-1",
																	"comment" : ""
																}

															}
 ],
														"lines" : [ 															{
																"patchline" : 																{
																	"source" : [ "obj-6", 0 ],
																	"destination" : [ "obj-12", 1 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-99", 0 ],
																	"destination" : [ "obj-39", 0 ],
																	"hidden" : 0,
																	"midpoints" : [ 17.5, 467.0, 157.0, 467.0, 157.0, 398.0, 180.75, 398.0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-94", 0 ],
																	"destination" : [ "obj-4", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-93", 0 ],
																	"destination" : [ "obj-108", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-9", 0 ],
																	"destination" : [ "obj-64", 0 ],
																	"hidden" : 0,
																	"midpoints" : [ 434.0, 166.0, 80.5, 166.0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-9", 1 ],
																	"destination" : [ "obj-58", 0 ],
																	"hidden" : 0,
																	"midpoints" : [ 446.0, 170.0, 56.75, 170.0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-9", 2 ],
																	"destination" : [ "obj-5", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-81", 0 ],
																	"destination" : [ "obj-79", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-80", 0 ],
																	"destination" : [ "obj-78", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-79", 0 ],
																	"destination" : [ "obj-44", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-78", 0 ],
																	"destination" : [ "obj-79", 1 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-77", 0 ],
																	"destination" : [ "obj-14", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-76", 0 ],
																	"destination" : [ "obj-39", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-74", 0 ],
																	"destination" : [ "obj-76", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-73", 0 ],
																	"destination" : [ "obj-64", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-73", 0 ],
																	"destination" : [ "obj-58", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-64", 0 ],
																	"destination" : [ "obj-39", 0 ],
																	"hidden" : 0,
																	"midpoints" : [ 80.5, 398.0, 180.75, 398.0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-58", 0 ],
																	"destination" : [ "obj-39", 0 ],
																	"hidden" : 0,
																	"midpoints" : [ 56.75, 398.0, 180.75, 398.0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-44", 0 ],
																	"destination" : [ "obj-39", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-41", 0 ],
																	"destination" : [ "obj-31", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-4", 1 ],
																	"destination" : [ "obj-93", 1 ],
																	"hidden" : 0,
																	"midpoints" : [ 714.5, 308.0, 552.5, 308.0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-4", 0 ],
																	"destination" : [ "obj-41", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-4", 0 ],
																	"destination" : [ "obj-17", 1 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-39", 0 ],
																	"destination" : [ "obj-77", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-31", 0 ],
																	"destination" : [ "obj-18", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-3", 0 ],
																	"destination" : [ "obj-31", 1 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-29", 0 ],
																	"destination" : [ "obj-9", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-22", 0 ],
																	"destination" : [ "obj-93", 1 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-2", 0 ],
																	"destination" : [ "obj-93", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-19", 1 ],
																	"destination" : [ "obj-5", 1 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-19", 0 ],
																	"destination" : [ "obj-17", 0 ],
																	"hidden" : 0,
																	"midpoints" : [ 539.5, 413.0, 624.5, 413.0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-18", 0 ],
																	"destination" : [ "obj-93", 1 ],
																	"hidden" : 0,
																	"midpoints" : [ 612.0, 307.0, 552.5, 307.0 ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-17", 0 ],
																	"destination" : [ "obj-22", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-14", 1 ],
																	"destination" : [ "obj-5", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-14", 0 ],
																	"destination" : [ "obj-102", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-11", 0 ],
																	"destination" : [ "obj-1", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-108", 0 ],
																	"destination" : [ "obj-19", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-102", 0 ],
																	"destination" : [ "obj-103", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-5", 0 ],
																	"destination" : [ "obj-10", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-10", 0 ],
																	"destination" : [ "obj-11", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-10", 1 ],
																	"destination" : [ "obj-12", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-12", 0 ],
																	"destination" : [ "obj-35", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
 ]
													}
,
													"saved_object_attributes" : 													{
														"fontface" : 0,
														"globalpatchername" : "",
														"fontsize" : 12.0,
														"default_fontface" : 0,
														"default_fontname" : "Arial",
														"fontname" : "Arial",
														"default_fontsize" : 12.0
													}

												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "bangbang",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 217.75, 565.0, 59.0, 19.0 ],
													"id" : "obj-44"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "Control response allowance period",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 229.5, 529.5, 95.0, 32.0 ],
													"id" : "obj-38"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "s start_resp_period",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"color" : [ 1.0, 0.0, 1.0, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 257.75, 588.0, 105.0, 19.0 ],
													"id" : "obj-37"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "s end_resp_period",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"color" : [ 1.0, 0.0, 1.0, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 217.75, 637.5, 102.0, 19.0 ],
													"id" : "obj-14"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "delay 1000",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 217.75, 611.5, 64.0, 19.0 ],
													"id" : "obj-8"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r std_amp_lvl",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 18.0, 459.5, 76.0, 19.0 ],
													"id" : "obj-36"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "*~",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "signal" ],
													"fontname" : "Arial",
													"patching_rect" : [ 4.0, 506.5, 32.5, 19.0 ],
													"id" : "obj-34"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "zl reg",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 162.75, 518.5, 37.0, 19.0 ],
													"id" : "obj-30"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "line~ 0.25",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "signal", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 162.75, 545.0, 59.0, 19.0 ],
													"id" : "obj-1"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t b f",
													"fontsize" : 12.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 501.0, 340.0, 32.5, 20.0 ],
													"id" : "obj-33"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "float",
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 501.0, 512.0, 33.0, 20.0 ],
													"id" : "obj-10"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "Mark ends of trials and count no. trials",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 412.0, 565.0, 102.0, 32.0 ],
													"id" : "obj-101"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "p trial_marker_counter",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 0,
													"color" : [ 1.0, 0.5, 0.0, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 399.0, 542.5, 121.0, 19.0 ],
													"id" : "obj-97",
													"patcher" : 													{
														"fileversion" : 1,
														"appversion" : 														{
															"major" : 5,
															"minor" : 1,
															"revision" : 9
														}
,
														"rect" : [ 912.0, 373.0, 487.0, 374.0 ],
														"bglocked" : 0,
														"defrect" : [ 912.0, 373.0, 487.0, 374.0 ],
														"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
														"openinpresentation" : 0,
														"default_fontsize" : 12.0,
														"default_fontface" : 0,
														"default_fontname" : "Arial",
														"gridonopen" : 0,
														"gridsize" : [ 15.0, 15.0 ],
														"gridsnaponopen" : 0,
														"toolbarvisible" : 1,
														"boxanimatetime" : 200,
														"imprint" : 0,
														"enablehscroll" : 1,
														"enablevscroll" : 1,
														"devicewidth" : 0.0,
														"visible" : 1,
														"boxes" : [ 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "send code 33 to python to indicate new trial",
																	"linecount" : 4,
																	"fontsize" : 12.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 133.0, 250.0, 79.0, 62.0 ],
																	"id" : "obj-14"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "s end_trial",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"color" : [ 1.0, 0.0, 1.0, 1.0 ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 63.0, 252.0, 61.0, 19.0 ],
																	"id" : "obj-79"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "button",
																	"numinlets" : 1,
																	"numoutlets" : 1,
																	"outlettype" : [ "bang" ],
																	"patching_rect" : [ 50.0, 217.0, 20.0, 20.0 ],
																	"id" : "obj-8"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "t b b 33",
																	"fontsize" : 12.0,
																	"numinlets" : 1,
																	"numoutlets" : 3,
																	"outlettype" : [ "bang", "bang", "int" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 87.0, 195.0, 51.0, 20.0 ],
																	"id" : "obj-12"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "s to_python",
																	"fontsize" : 12.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 131.0, 224.0, 73.0, 20.0 ],
																	"id" : "obj-11"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "number~",
																	"mode" : 2,
																	"fontsize" : 12.0,
																	"numinlets" : 2,
																	"sig" : 0.0,
																	"numoutlets" : 2,
																	"outlettype" : [ "signal", "float" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 9.0, 174.0, 56.0, 20.0 ],
																	"id" : "obj-7"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "number",
																	"fontsize" : 12.0,
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "int", "bang" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 224.75, 243.0, 50.0, 20.0 ],
																	"id" : "obj-2"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "count no. trials",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 224.75, 111.0, 85.0, 19.0 ],
																	"id" : "obj-92"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "r start_run",
																	"fontsize" : 11.0,
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"color" : [ 0.0, 1.0, 1.0, 1.0 ],
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 261.75, 134.0, 61.0, 19.0 ],
																	"id" : "obj-90"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "r lb",
																	"fontsize" : 11.0,
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"color" : [ 0.0, 1.0, 1.0, 1.0 ],
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 224.75, 134.0, 26.0, 19.0 ],
																	"id" : "obj-89"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "message",
																	"text" : "1",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 261.75, 164.0, 33.0, 17.0 ],
																	"id" : "obj-88"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "s trial_num",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"color" : [ 1.0, 0.0, 1.0, 1.0 ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 242.25, 219.0, 64.0, 19.0 ],
																	"id" : "obj-86"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "counter",
																	"fontsize" : 11.0,
																	"numinlets" : 5,
																	"numoutlets" : 4,
																	"outlettype" : [ "int", "", "", "int" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 224.75, 194.0, 68.0, 19.0 ],
																	"id" : "obj-85"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "trial boundary detection",
																	"linecount" : 2,
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 14.5, 99.0, 78.0, 32.0 ],
																	"id" : "obj-80"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : "edge~",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 2,
																	"outlettype" : [ "bang", "bang" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 87.0, 164.0, 41.0, 19.0 ],
																	"id" : "obj-63"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "newobj",
																	"text" : ">=~",
																	"fontsize" : 11.0,
																	"numinlets" : 2,
																	"numoutlets" : 1,
																	"outlettype" : [ "signal" ],
																	"fontname" : "Arial",
																	"patching_rect" : [ 87.0, 134.0, 32.5, 19.0 ],
																	"id" : "obj-61"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "trial boundary tolerance",
																	"linecount" : 2,
																	"fontsize" : 12.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 222.25, 27.0, 90.0, 34.0 ],
																	"id" : "obj-6"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "float" ],
																	"patching_rect" : [ 254.75, 60.0, 25.0, 25.0 ],
																	"id" : "obj-4",
																	"comment" : ""
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "comment",
																	"text" : "loop time sig (ms)",
																	"fontsize" : 11.0,
																	"numinlets" : 1,
																	"numoutlets" : 0,
																	"fontname" : "Arial",
																	"patching_rect" : [ 50.5, 34.0, 98.0, 19.0 ],
																	"id" : "obj-3"
																}

															}
, 															{
																"box" : 																{
																	"maxclass" : "inlet",
																	"numinlets" : 0,
																	"numoutlets" : 1,
																	"outlettype" : [ "signal" ],
																	"patching_rect" : [ 87.0, 60.0, 25.0, 25.0 ],
																	"id" : "obj-1",
																	"comment" : ""
																}

															}
 ],
														"lines" : [ 															{
																"patchline" : 																{
																	"source" : [ "obj-12", 0 ],
																	"destination" : [ "obj-8", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-12", 1 ],
																	"destination" : [ "obj-79", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-63", 0 ],
																	"destination" : [ "obj-12", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-12", 2 ],
																	"destination" : [ "obj-11", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-90", 0 ],
																	"destination" : [ "obj-88", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-89", 0 ],
																	"destination" : [ "obj-88", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-88", 0 ],
																	"destination" : [ "obj-85", 2 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-85", 0 ],
																	"destination" : [ "obj-86", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-85", 0 ],
																	"destination" : [ "obj-2", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-63", 0 ],
																	"destination" : [ "obj-85", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-61", 0 ],
																	"destination" : [ "obj-7", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-61", 0 ],
																	"destination" : [ "obj-63", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-4", 0 ],
																	"destination" : [ "obj-61", 1 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
, 															{
																"patchline" : 																{
																	"source" : [ "obj-1", 0 ],
																	"destination" : [ "obj-61", 0 ],
																	"hidden" : 0,
																	"midpoints" : [  ]
																}

															}
 ]
													}
,
													"saved_object_attributes" : 													{
														"fontface" : 0,
														"globalpatchername" : "",
														"fontsize" : 12.0,
														"default_fontface" : 0,
														"default_fontname" : "Arial",
														"fontname" : "Arial",
														"default_fontsize" : 12.0
													}

												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "trial boundary",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 448.625, 438.0, 55.375, 32.0 ],
													"id" : "obj-82"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "number~",
													"mode" : 2,
													"fontsize" : 11.0,
													"numinlets" : 2,
													"sig" : 0.0,
													"numoutlets" : 2,
													"outlettype" : [ "signal", "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 19.0, 282.0, 106.0, 19.0 ],
													"id" : "obj-78"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "- 150.",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 412.0, 444.0, 39.0, 19.0 ],
													"id" : "obj-56"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "elapsed time (ms)",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 19.0, 301.0, 99.0, 19.0 ],
													"id" : "obj-50"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "*~",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "signal" ],
													"fontname" : "Arial",
													"patching_rect" : [ 162.75, 282.0, 31.0, 19.0 ],
													"id" : "obj-41"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "button",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 421.5, 282.0, 20.0, 20.0 ],
													"id" : "obj-40"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "flonum",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "float", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 412.0, 409.0, 87.0, 19.0 ],
													"id" : "obj-32"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "info~ stim",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 8,
													"outlettype" : [ "float", "list", "float", "float", "float", "float", "float", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 421.5, 313.0, 125.0, 19.0 ],
													"id" : "obj-28"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "sample duration (ms)",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 424.0, 378.0, 78.0, 32.0 ],
													"id" : "obj-18"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "Load stim file into buffer, replace with new stim file in subsequent runs",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 361.0, 106.0, 195.0, 32.0 ],
													"id" : "obj-39"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r start_run",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 484.0, 145.0, 61.0, 19.0 ],
													"id" : "obj-27"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "zl reg",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 450.0, 195.0, 37.0, 19.0 ],
													"id" : "obj-26"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "onebang",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 450.0, 169.5, 53.0, 19.0 ],
													"id" : "obj-25"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "prepend replace",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 450.0, 218.0, 90.0, 19.0 ],
													"id" : "obj-19"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "sig~ 1.",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "signal" ],
													"fontname" : "Arial",
													"patching_rect" : [ 193.25, 218.0, 43.0, 19.0 ],
													"id" : "obj-23"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "playback speed",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 200.25, 185.0, 55.0, 32.0 ],
													"id" : "obj-21"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "start time",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 127.0, 196.0, 54.0, 19.0 ],
													"id" : "obj-17"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "flonum",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "float", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 126.0, 218.0, 49.0, 19.0 ],
													"id" : "obj-12"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r stim_fpath",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 361.0, 145.0, 68.0, 19.0 ],
													"id" : "obj-6"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "prepend read",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 361.0, 218.0, 76.0, 19.0 ],
													"id" : "obj-42"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "buffer~ stim",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "float", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 450.0, 244.0, 68.0, 19.0 ],
													"id" : "obj-46"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "Amplitude deviant envelope",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 244.0, 10.0, 99.0, 32.0 ],
													"id" : "obj-31"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r end_run",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 67.0, 145.0, 58.0, 19.0 ],
													"id" : "obj-29"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r start_run",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 4.0, 145.0, 61.0, 19.0 ],
													"id" : "obj-4"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "stop",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 67.0, 218.0, 32.0, 17.0 ],
													"id" : "obj-24"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "startloop",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 4.0, 218.0, 53.0, 17.0 ],
													"id" : "obj-22"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "groove~ stim @loop 1",
													"fontsize" : 11.0,
													"numinlets" : 3,
													"numoutlets" : 2,
													"outlettype" : [ "signal", "signal" ],
													"fontname" : "Arial",
													"patching_rect" : [ 4.0, 253.0, 177.75, 19.0 ],
													"id" : "obj-16"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "- Upon initiation of a run, start loop playback after 5 sec delay\n- Stop playback when end_run.",
													"linecount" : 3,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 4.0, 94.0, 251.0, 44.0 ],
													"id" : "obj-9"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 281.0, 44.0, 25.0, 25.0 ],
													"id" : "obj-3",
													"comment" : ""
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"source" : [ "obj-8", 0 ],
													"destination" : [ "obj-14", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-7", 0 ],
													"destination" : [ "obj-43", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-6", 0 ],
													"destination" : [ "obj-42", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-6", 0 ],
													"destination" : [ "obj-26", 1 ],
													"hidden" : 0,
													"midpoints" : [ 370.5, 191.0, 477.5, 191.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-6", 0 ],
													"destination" : [ "obj-25", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-56", 0 ],
													"destination" : [ "obj-10", 1 ],
													"hidden" : 0,
													"midpoints" : [ 421.5, 486.5, 524.5, 486.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-52", 0 ],
													"destination" : [ "obj-51", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-51", 0 ],
													"destination" : [ "obj-2", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-49", 0 ],
													"destination" : [ "obj-5", 0 ],
													"hidden" : 0,
													"midpoints" : [ 65.0, 628.75, 13.5, 628.75 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-46", 1 ],
													"destination" : [ "obj-40", 0 ],
													"hidden" : 0,
													"midpoints" : [ 508.5, 272.0, 431.0, 272.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-44", 0 ],
													"destination" : [ "obj-8", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-44", 1 ],
													"destination" : [ "obj-37", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-43", 0 ],
													"destination" : [ "obj-5", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-42", 0 ],
													"destination" : [ "obj-46", 0 ],
													"hidden" : 0,
													"midpoints" : [ 370.5, 240.0, 459.5, 240.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-41", 0 ],
													"destination" : [ "obj-97", 0 ],
													"hidden" : 0,
													"midpoints" : [ 172.25, 421.25, 408.5, 421.25 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-41", 0 ],
													"destination" : [ "obj-78", 0 ],
													"hidden" : 0,
													"midpoints" : [ 172.25, 308.0, 148.375, 308.0, 148.375, 276.0, 28.5, 276.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-41", 0 ],
													"destination" : [ "obj-11", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-40", 0 ],
													"destination" : [ "obj-28", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-4", 0 ],
													"destination" : [ "obj-22", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-36", 0 ],
													"destination" : [ "obj-34", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-34", 0 ],
													"destination" : [ "obj-5", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-34", 0 ],
													"destination" : [ "obj-5", 1 ],
													"hidden" : 0,
													"midpoints" : [ 13.5, 628.25, 29.5, 628.25 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-33", 1 ],
													"destination" : [ "obj-32", 0 ],
													"hidden" : 0,
													"midpoints" : [ 524.0, 368.0, 421.5, 368.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-33", 0 ],
													"destination" : [ "obj-10", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-32", 0 ],
													"destination" : [ "obj-56", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-32", 0 ],
													"destination" : [ "obj-41", 1 ],
													"hidden" : 0,
													"midpoints" : [ 421.5, 432.0, 204.0, 432.0, 204.0, 279.0, 184.25, 279.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-32", 0 ],
													"destination" : [ "obj-11", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-30", 0 ],
													"destination" : [ "obj-44", 0 ],
													"hidden" : 0,
													"midpoints" : [ 172.25, 540.75, 227.25, 540.75 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-30", 0 ],
													"destination" : [ "obj-1", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-3", 0 ],
													"destination" : [ "obj-30", 1 ],
													"hidden" : 0,
													"midpoints" : [ 290.5, 504.0, 190.25, 504.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-29", 0 ],
													"destination" : [ "obj-24", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-28", 6 ],
													"destination" : [ "obj-33", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-27", 0 ],
													"destination" : [ "obj-25", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-26", 0 ],
													"destination" : [ "obj-19", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-25", 0 ],
													"destination" : [ "obj-26", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-24", 0 ],
													"destination" : [ "obj-16", 0 ],
													"hidden" : 0,
													"midpoints" : [ 76.5, 243.5, 13.5, 243.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-23", 0 ],
													"destination" : [ "obj-16", 0 ],
													"hidden" : 0,
													"midpoints" : [ 202.75, 244.5, 13.5, 244.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-22", 0 ],
													"destination" : [ "obj-16", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-20", 0 ],
													"destination" : [ "obj-52", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-2", 0 ],
													"destination" : [ "obj-16", 0 ],
													"hidden" : 0,
													"midpoints" : [ 270.5, 248.0, 13.5, 248.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-19", 0 ],
													"destination" : [ "obj-46", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-16", 1 ],
													"destination" : [ "obj-41", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-16", 0 ],
													"destination" : [ "obj-34", 0 ],
													"hidden" : 0,
													"midpoints" : [ 13.5, 440.0, 13.5, 440.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-15", 0 ],
													"destination" : [ "obj-24", 0 ],
													"hidden" : 0,
													"midpoints" : [ 137.5, 169.5, 76.5, 169.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-13", 0 ],
													"destination" : [ "obj-12", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-12", 0 ],
													"destination" : [ "obj-16", 0 ],
													"hidden" : 0,
													"midpoints" : [ 135.5, 244.5, 13.5, 244.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-11", 0 ],
													"destination" : [ "obj-30", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-10", 0 ],
													"destination" : [ "obj-97", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-1", 0 ],
													"destination" : [ "obj-34", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
 ]
									}
,
									"saved_object_attributes" : 									{
										"fontface" : 0,
										"globalpatchername" : "",
										"fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"fontname" : "Arial",
										"default_fontsize" : 12.0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "p calculate_deviant_envlp",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 1.0, 0.5, 0.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 18.0, 157.0, 149.0, 20.0 ],
									"id" : "obj-1",
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 5,
											"minor" : 1,
											"revision" : 9
										}
,
										"rect" : [ 544.0, 48.0, 552.0, 664.0 ],
										"bglocked" : 0,
										"defrect" : [ 544.0, 48.0, 552.0, 664.0 ],
										"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 0,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 0,
										"toolbarvisible" : 1,
										"boxanimatetime" : 200,
										"imprint" : 0,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"boxes" : [ 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "linear ramp of deviant envelope",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 63.5, 490.0, 111.0, 32.0 ],
													"id" : "obj-59"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t b f f",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "bang", "float", "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 29.0, 386.0, 133.333328, 19.0 ],
													"id" : "obj-53"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "de-log deviance value",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 106.0, 227.0, 89.0, 32.0 ],
													"id" : "obj-52"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "dBtoA_refScale",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"color" : [ 1.0, 0.5, 0.0, 1.0 ],
													"outlettype" : [ "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 29.0, 337.0, 87.0, 19.0 ],
													"id" : "obj-50"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "float",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 29.0, 424.0, 31.0, 19.0 ],
													"id" : "obj-33"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t f f f",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 3,
													"outlettype" : [ "float", "float", "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 181.5, 361.0, 38.0, 19.0 ],
													"id" : "obj-30"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r std_amp_lvl",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 193.5, 311.0, 76.0, 19.0 ],
													"id" : "obj-22"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "button",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 64.0, 156.0, 20.0, 20.0 ],
													"id" : "obj-28"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t 10 f",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 64.0, 212.0, 35.0, 19.0 ],
													"id" : "obj-25"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "pow",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 64.0, 239.0, 35.0, 19.0 ],
													"id" : "obj-26"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "zl reg",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 64.0, 185.0, 37.0, 19.0 ],
													"id" : "obj-23"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r mean_pdf",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 82.0, 156.0, 66.0, 19.0 ],
													"id" : "obj-24"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t 10 f",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 197.0, 212.0, 35.0, 19.0 ],
													"id" : "obj-51"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "pow",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 197.0, 239.0, 35.0, 19.0 ],
													"id" : "obj-17"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "determine mean_pdf idx based on obs #",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 129.5, 61.0, 119.0, 32.0 ],
													"id" : "obj-16"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "bangbang",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "bang", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 29.0, 96.0, 59.0, 19.0 ],
													"id" : "obj-15"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "zl nth",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 197.0, 185.0, 37.0, 19.0 ],
													"id" : "obj-12"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "- 1",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 276.5, 156.0, 32.5, 19.0 ],
													"id" : "obj-8"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r obs_num",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 129.5, 96.0, 62.0, 19.0 ],
													"id" : "obj-4"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "if $i1 == 1 then $i1 else out2 $i1",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 129.5, 125.0, 166.0, 19.0 ],
													"id" : "obj-2"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "flonum",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "float", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 29.0, 361.0, 49.0, 19.0 ],
													"id" : "obj-13"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "transform to linear amp",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 41.5, 317.0, 133.0, 19.0 ],
													"id" : "obj-38"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "float",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "float" ],
													"fontname" : "Arial",
													"patching_rect" : [ 181.5, 336.0, 31.0, 19.0 ],
													"id" : "obj-34"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 29.0, 493.0, 25.0, 25.0 ],
													"id" : "obj-11",
													"comment" : ""
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "sprintf %f\\, %f 1 %f 200 %f 1",
													"fontsize" : 11.0,
													"numinlets" : 4,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 29.0, 452.0, 191.0, 19.0 ],
													"id" : "obj-10"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "After each probe time is selected, calculate amplitude modulation envelope given ZEST estimate for that probe",
													"linecount" : 2,
													"fontface" : 2,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 14.0, 11.0, 288.0, 32.0 ],
													"id" : "obj-9"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r probe_idx",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 29.0, 61.0, 66.0, 19.0 ],
													"id" : "obj-6"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "17.765675",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 29.0, 274.0, 60.5, 17.0 ],
													"id" : "obj-3"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r mean_pdf",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 197.0, 156.0, 66.0, 19.0 ],
													"id" : "obj-1"
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"source" : [ "obj-8", 0 ],
													"destination" : [ "obj-12", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-6", 0 ],
													"destination" : [ "obj-15", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-53", 0 ],
													"destination" : [ "obj-33", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-53", 1 ],
													"destination" : [ "obj-10", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-53", 2 ],
													"destination" : [ "obj-10", 2 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-51", 0 ],
													"destination" : [ "obj-17", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-51", 1 ],
													"destination" : [ "obj-17", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-50", 0 ],
													"destination" : [ "obj-13", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-4", 0 ],
													"destination" : [ "obj-2", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-34", 0 ],
													"destination" : [ "obj-30", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-33", 0 ],
													"destination" : [ "obj-10", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-30", 1 ],
													"destination" : [ "obj-50", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-30", 0 ],
													"destination" : [ "obj-33", 1 ],
													"hidden" : 0,
													"midpoints" : [ 191.0, 419.0, 50.5, 419.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-30", 2 ],
													"destination" : [ "obj-10", 3 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-3", 0 ],
													"destination" : [ "obj-50", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-28", 0 ],
													"destination" : [ "obj-23", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-26", 0 ],
													"destination" : [ "obj-3", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-25", 0 ],
													"destination" : [ "obj-26", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-25", 1 ],
													"destination" : [ "obj-26", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-24", 0 ],
													"destination" : [ "obj-23", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-23", 0 ],
													"destination" : [ "obj-25", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-22", 0 ],
													"destination" : [ "obj-34", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-2", 1 ],
													"destination" : [ "obj-8", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-2", 0 ],
													"destination" : [ "obj-28", 0 ],
													"hidden" : 0,
													"midpoints" : [ 139.0, 148.0, 73.5, 148.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-17", 0 ],
													"destination" : [ "obj-3", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-15", 1 ],
													"destination" : [ "obj-34", 0 ],
													"hidden" : 0,
													"midpoints" : [ 78.5, 269.5, 191.0, 269.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-15", 0 ],
													"destination" : [ "obj-3", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-13", 0 ],
													"destination" : [ "obj-53", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-12", 0 ],
													"destination" : [ "obj-51", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-10", 0 ],
													"destination" : [ "obj-11", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-1", 0 ],
													"destination" : [ "obj-12", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
 ]
									}
,
									"saved_object_attributes" : 									{
										"fontface" : 0,
										"globalpatchername" : "",
										"fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"fontname" : "Arial",
										"default_fontsize" : 12.0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Write trial data to data file",
									"fontface" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 18.0, 426.0, 244.0, 20.0 ],
									"id" : "obj-4"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Collect subject target detection response",
									"fontface" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 18.0, 340.0, 244.0, 20.0 ],
									"id" : "obj-7"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Start playback at exp_start, present target deviant, and track trial (i.e., loop iteration) number",
									"linecount" : 3,
									"fontface" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 38.0, 217.0, 222.0, 48.0 ],
									"id" : "obj-5"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Calculate amplitude deviant level for upcoming probe using ZEST calculations",
									"linecount" : 2,
									"fontface" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 18.0, 114.0, 244.0, 34.0 ],
									"id" : "obj-3"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "p probe_time_select",
									"fontsize" : 12.0,
									"numinlets" : 0,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.5, 0.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 18.0, 55.0, 119.0, 20.0 ],
									"id" : "obj-38",
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 5,
											"minor" : 1,
											"revision" : 9
										}
,
										"rect" : [ 577.0, 45.0, 612.0, 599.0 ],
										"bglocked" : 0,
										"defrect" : [ 577.0, 45.0, 612.0, 599.0 ],
										"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 0,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 0,
										"toolbarvisible" : 1,
										"boxanimatetime" : 200,
										"imprint" : 0,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"boxes" : [ 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "low_reson",
													"linecount" : 2,
													"fontsize" : 12.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 377.0, 356.0, 54.0, 32.0 ],
													"id" : "obj-18"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "tosymbol",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 284.5, 329.0, 55.0, 19.0 ],
													"id" : "obj-16"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "t i i b b i i",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 6,
													"outlettype" : [ "int", "int", "bang", "bang", "int", "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 191.0, 247.0, 86.5, 19.0 ],
													"id" : "obj-28"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "s probe_cond",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"color" : [ 1.0, 0.0, 1.0, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 284.5, 356.0, 77.0, 19.0 ],
													"id" : "obj-13"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "zl nth",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 284.5, 302.0, 37.0, 19.0 ],
													"id" : "obj-14"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "low_reson low_reson hi_reson hi_reson",
													"linecount" : 3,
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 373.5, 271.0, 103.0, 42.0 ],
													"id" : "obj-11"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r curr_probe_conds",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 284.5, 240.0, 106.0, 19.0 ],
													"id" : "obj-1"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "123. 541. 1111. 1947.",
													"linecount" : 2,
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 39.0, 273.0, 103.0, 30.0 ],
													"id" : "obj-9"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r select_next",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 85.75, 102.0, 73.0, 19.0 ],
													"id" : "obj-26"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "s select_next",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"color" : [ 1.0, 0.0, 1.0, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 52.5, 481.0, 75.0, 19.0 ],
													"id" : "obj-25"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "if $i1==1 then bang else out2 $i2",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 52.5, 453.0, 171.0, 19.0 ],
													"id" : "obj-21"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "coll converge",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 52.5, 423.0, 75.0, 19.0 ],
													"id" : "obj-15",
													"saved_object_attributes" : 													{
														"embed" : 0
													}

												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "prepend nth conv_msk",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 52.5, 399.0, 122.0, 19.0 ],
													"id" : "obj-12"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "If threshold for this probe has converged, skip and go to next selection. \nOtherwise, continue with selected probe.",
													"linecount" : 5,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 230.75, 404.0, 146.0, 70.0 ],
													"id" : "obj-10"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "comment",
													"text" : "Randomly select probe time from times associated with current stim each time (a) slots are loaded for a new run, (b) a probe is applied by the stim player, or (c) the threshold tracker associated with the chosen probe has already converged",
													"linecount" : 3,
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"fontname" : "Arial",
													"patching_rect" : [ 13.0, 11.0, 404.0, 44.0 ],
													"id" : "obj-2"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "s probe_time",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"color" : [ 1.0, 0.0, 1.0, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 46.0, 341.0, 74.0, 19.0 ],
													"id" : "obj-33"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "s probe_idx",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 0,
													"color" : [ 1.0, 0.0, 1.0, 1.0 ],
													"fontname" : "Arial",
													"patching_rect" : [ 204.5, 481.0, 67.0, 19.0 ],
													"id" : "obj-31"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "message",
													"text" : "clear",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 221.0, 130.0, 34.0, 17.0 ],
													"id" : "obj-30"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "button",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 191.0, 130.0, 20.0, 20.0 ],
													"id" : "obj-24"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "number",
													"fontsize" : 11.0,
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 191.0, 220.0, 50.0, 19.0 ],
													"id" : "obj-34"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "+ 1",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"fontname" : "Arial",
													"patching_rect" : [ 191.0, 195.0, 30.0, 19.0 ],
													"id" : "obj-32"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r probe_applied",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 275.0, 82.0, 87.0, 19.0 ],
													"id" : "obj-8"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r slots_loaded",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 173.0, 82.0, 79.0, 19.0 ],
													"id" : "obj-7"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r n_probe_times",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 268.0, 130.0, 90.0, 19.0 ],
													"id" : "obj-6"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "urn",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "int", "bang" ],
													"fontname" : "Arial",
													"patching_rect" : [ 191.0, 168.0, 30.0, 19.0 ],
													"id" : "obj-5"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "zl nth",
													"fontsize" : 11.0,
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 46.0, 313.0, 37.0, 19.0 ],
													"id" : "obj-4"
												}

											}
, 											{
												"box" : 												{
													"maxclass" : "newobj",
													"text" : "r curr_probe_times",
													"fontsize" : 11.0,
													"numinlets" : 0,
													"numoutlets" : 1,
													"color" : [ 0.0, 1.0, 1.0, 1.0 ],
													"outlettype" : [ "" ],
													"fontname" : "Arial",
													"patching_rect" : [ 39.0, 240.0, 103.0, 19.0 ],
													"id" : "obj-3"
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"source" : [ "obj-9", 0 ],
													"destination" : [ "obj-4", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-8", 0 ],
													"destination" : [ "obj-24", 0 ],
													"hidden" : 0,
													"midpoints" : [ 284.5, 107.0, 200.5, 107.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-7", 0 ],
													"destination" : [ "obj-30", 0 ],
													"hidden" : 0,
													"midpoints" : [ 182.5, 111.0, 230.5, 111.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-7", 0 ],
													"destination" : [ "obj-24", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-6", 0 ],
													"destination" : [ "obj-5", 1 ],
													"hidden" : 0,
													"midpoints" : [ 277.5, 165.0, 211.5, 165.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-5", 0 ],
													"destination" : [ "obj-32", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-5", 1 ],
													"destination" : [ "obj-30", 0 ],
													"hidden" : 0,
													"midpoints" : [ 211.5, 191.0, 375.25, 191.0, 375.25, 120.0, 230.5, 120.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-5", 1 ],
													"destination" : [ "obj-24", 0 ],
													"hidden" : 0,
													"midpoints" : [ 211.5, 191.0, 263.25, 191.0, 263.25, 120.0, 200.5, 120.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-4", 0 ],
													"destination" : [ "obj-33", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-32", 0 ],
													"destination" : [ "obj-34", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-30", 0 ],
													"destination" : [ "obj-5", 0 ],
													"hidden" : 0,
													"midpoints" : [ 230.5, 150.0, 200.5, 150.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-3", 0 ],
													"destination" : [ "obj-9", 1 ],
													"hidden" : 0,
													"midpoints" : [ 48.5, 263.5, 132.5, 263.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-26", 0 ],
													"destination" : [ "obj-24", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-24", 0 ],
													"destination" : [ "obj-5", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-21", 1 ],
													"destination" : [ "obj-31", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-21", 0 ],
													"destination" : [ "obj-25", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-16", 0 ],
													"destination" : [ "obj-18", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-16", 0 ],
													"destination" : [ "obj-13", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-15", 0 ],
													"destination" : [ "obj-21", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-14", 0 ],
													"destination" : [ "obj-16", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-12", 0 ],
													"destination" : [ "obj-15", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-11", 0 ],
													"destination" : [ "obj-14", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-1", 0 ],
													"destination" : [ "obj-11", 1 ],
													"hidden" : 0,
													"midpoints" : [ 294.0, 265.5, 467.0, 265.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-28", 3 ],
													"destination" : [ "obj-11", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-28", 0 ],
													"destination" : [ "obj-12", 0 ],
													"hidden" : 0,
													"midpoints" : [ 200.5, 391.0, 62.0, 391.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-28", 5 ],
													"destination" : [ "obj-14", 1 ],
													"hidden" : 0,
													"midpoints" : [ 268.0, 296.5, 312.0, 296.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-28", 1 ],
													"destination" : [ "obj-21", 1 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-28", 4 ],
													"destination" : [ "obj-4", 1 ],
													"hidden" : 0,
													"midpoints" : [ 254.5, 296.5, 73.5, 296.5 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-28", 2 ],
													"destination" : [ "obj-9", 0 ],
													"hidden" : 0,
													"midpoints" : [ 227.5, 269.0, 48.5, 269.0 ]
												}

											}
, 											{
												"patchline" : 												{
													"source" : [ "obj-34", 0 ],
													"destination" : [ "obj-28", 0 ],
													"hidden" : 0,
													"midpoints" : [  ]
												}

											}
 ]
									}
,
									"saved_object_attributes" : 									{
										"fontface" : 0,
										"globalpatchername" : "",
										"fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"fontname" : "Arial",
										"default_fontsize" : 12.0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Playback stimulus, select times to probe and produce amp deviant, collect response",
									"linecount" : 2,
									"fontface" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 18.0, 12.0, 242.0, 34.0 ],
									"id" : "obj-2"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-6", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"globalpatchername" : "",
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Estimate threshold and maintain separate treshold trackers for each probe type",
					"linecount" : 3,
					"fontface" : 2,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 575.0, 269.5, 178.0, 48.0 ],
					"id" : "obj-16"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "manage_zest_contexts",
					"text" : "p manage_zest_contexts",
					"fontsize" : 12.0,
					"numinlets" : 0,
					"numoutlets" : 0,
					"color" : [ 1.0, 0.5, 0.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 575.0, 321.5, 144.0, 20.0 ],
					"id" : "obj-15",
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 5,
							"minor" : 1,
							"revision" : 9
						}
,
						"rect" : [ 266.0, 69.0, 762.0, 756.0 ],
						"bglocked" : 0,
						"defrect" : [ 266.0, 69.0, 762.0, 756.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "send end run code (88) to python",
									"linecount" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 578.0, 688.0, 111.0, 34.0 ],
									"id" : "obj-56"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s to_python",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 538.0, 725.0, 73.0, 20.0 ],
									"id" : "obj-51"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "88",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 538.0, 701.0, 32.5, 18.0 ],
									"id" : "obj-45"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b i",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 442.0, 454.0, 32.5, 19.0 ],
									"id" : "obj-50"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "1",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 442.0, 479.0, 38.0, 17.0 ],
									"id" : "obj-47"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "clear",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 489.0, 554.5, 34.0, 17.0 ],
									"id" : "obj-31"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "bangbang 3",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 455.5, 656.5, 69.0, 19.0 ],
									"id" : "obj-29"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r obs_num",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 259.5, 602.0, 62.0, 19.0 ],
									"id" : "obj-32"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r calc_params",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 103.5, 602.0, 80.0, 19.0 ],
									"id" : "obj-28"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"varname" : "u923000138",
									"text" : "autopattr",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 471.0, 40.0, 59.5, 19.0 ],
									"id" : "obj-67",
									"restore" : 									{
										"obs_num" : [ 4 ]
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s calc_params",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 120.5, 264.0, 81.0, 19.0 ],
									"id" : "obj-54"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend set",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 533.0, 357.0, 69.0, 19.0 ],
									"id" : "obj-27"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "+ 1",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 533.0, 334.0, 32.5, 19.0 ],
									"id" : "obj-64"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 102.5, 453.0, 20.0, 20.0 ],
									"id" : "obj-46"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Store values to current probe slot once thresh values calculated for current trial",
									"linecount" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 102.5, 394.0, 201.0, 32.0 ],
									"id" : "obj-42"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r conv_indicator",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 102.5, 425.0, 88.0, 19.0 ],
									"id" : "obj-41"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "1",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 141.0, 449.0, 38.0, 17.0 ],
									"id" : "obj-40"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r probe_idx",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 198.9375, 425.0, 66.0, 19.0 ],
									"id" : "obj-39"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend store",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 141.0, 471.0, 78.0, 19.0 ],
									"id" : "obj-36"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b b i",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 442.0, 305.0, 68.0, 19.0 ],
									"id" : "obj-19"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s conv_indicator",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 207.5, 663.0, 90.0, 19.0 ],
									"id" : "obj-14"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b l",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 442.0, 526.5, 32.5, 19.0 ],
									"id" : "obj-9"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "onebang",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 103.5, 574.5, 53.0, 19.0 ],
									"id" : "obj-25"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r end_trial",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 103.5, 547.5, 59.0, 19.0 ],
									"id" : "obj-7"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "0",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 181.5, 583.5, 50.0, 17.0 ],
									"id" : "obj-48"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r sub_resp",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 212.5, 547.5, 62.0, 19.0 ],
									"id" : "obj-18"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s end_run",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 455.5, 694.0, 59.0, 19.0 ],
									"id" : "obj-65"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "if $i1 == $i2 then bang",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 455.5, 633.5, 119.0, 19.0 ],
									"id" : "obj-62"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r n_probe_times",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 555.5, 607.5, 90.0, 19.0 ],
									"id" : "obj-49"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl sum",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 455.5, 607.5, 42.0, 19.0 ],
									"id" : "obj-35"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "dump",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 417.5, 554.5, 38.0, 17.0 ],
									"id" : "obj-30"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Update convergence tracker and send bang when all probes converged",
									"linecount" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 482.0, 433.0, 201.0, 32.0 ],
									"id" : "obj-23"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r probe_idx",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 482.0, 479.0, 66.0, 19.0 ],
									"id" : "obj-11"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sprintf nsub conv_msk %d %d",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 442.0, 501.0, 158.0, 19.0 ],
									"id" : "obj-5"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "coll converge",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 455.5, 581.5, 75.0, 19.0 ],
									"id" : "obj-4",
									"saved_object_attributes" : 									{
										"embed" : 0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r params_fname",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 288.0, 140.0, 91.0, 19.0 ],
									"id" : "obj-60"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b b 1 b b",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 5,
									"outlettype" : [ "bang", "bang", "int", "bang", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 102.5, 148.5, 91.0, 19.0 ],
									"id" : "obj-59"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "number",
									"varname" : "obs_num",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "int", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 466.5, 334.0, 50.0, 19.0 ],
									"id" : "obj-38"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "clear",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 429.5, 110.0, 34.0, 17.0 ],
									"id" : "obj-26"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s obs_num",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 442.0, 387.0, 64.0, 19.0 ],
									"id" : "obj-37"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "counter",
									"fontsize" : 11.0,
									"numinlets" : 5,
									"numoutlets" : 4,
									"outlettype" : [ "int", "", "", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 442.0, 361.0, 68.0, 19.0 ],
									"id" : "obj-34"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r probe_idx",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 442.0, 280.0, 66.0, 19.0 ],
									"id" : "obj-20"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Switch to current probe's threshold tracker and add to this probe's observation counter",
									"linecount" : 3,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 442.0, 233.0, 189.0, 44.0 ],
									"id" : "obj-17"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r start_run",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 102.5, 124.0, 61.0, 19.0 ],
									"id" : "obj-15"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s slots_loaded",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 115.5, 350.0, 81.0, 19.0 ],
									"id" : "obj-13"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend store",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 157.5, 320.0, 78.0, 19.0 ],
									"id" : "obj-10"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r n_probe_times",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 128.5, 293.0, 90.0, 19.0 ],
									"id" : "obj-6"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "uzi",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 102.5, 320.0, 45.0, 19.0 ],
									"id" : "obj-1"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "\"Macintosh HD:/Users/laurenfink/Documents/3_Quarter/Experiment/attmap_params_v1p2.xml\"",
									"linecount" : 4,
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 156.5, 181.0, 208.0, 55.0 ],
									"id" : "obj-24"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend read",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 156.5, 227.5, 76.0, 19.0 ],
									"id" : "obj-22"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Initialize pattrstorage slots by reading in param presets and storing to slots.\n# slots = # probe times",
									"linecount" : 3,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 92.5, 76.5, 206.875, 44.0 ],
									"id" : "obj-21"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "clientwindow",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 448.0, 135.0, 73.0, 17.0 ],
									"id" : "obj-8"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Functions as a wrapper for the ZEST threshold patch.\nManages switching among the individual threshold trackers linked to each probe type.",
									"linecount" : 2,
									"fontface" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 30.0, 28.0, 428.0, 32.0 ],
									"id" : "obj-2"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Pass subject response to ZEST upon trial end, output convergence indicator",
									"linecount" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 103.5, 510.5, 198.0, 32.0 ],
									"id" : "obj-33"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "storagewindow",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 471.0, 159.0, 84.0, 17.0 ],
									"id" : "obj-16"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"varname" : "zest",
									"text" : "pattrstorage zest @savemode 0",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 429.5, 192.0, 167.0, 19.0 ],
									"id" : "obj-12",
									"autorestore" : "attmap_params_v1p2.xml",
									"saved_object_attributes" : 									{
										"paraminitmode" : 0,
										"storage_rect" : [ 684, 94, 1244, 560 ],
										"client_rect" : [ 109, 45, 1205, 407 ],
										"parameter_enable" : 0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"varname" : "zest_pattr",
									"text" : "zest_pattr",
									"fontsize" : 11.0,
									"numinlets" : 3,
									"numoutlets" : 4,
									"color" : [ 1.0, 0.5, 0.0, 1.0 ],
									"outlettype" : [ "", "", "int", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 103.5, 628.0, 175.0, 19.0 ],
									"id" : "obj-3"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-9", 1 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-9", 0 ],
									"destination" : [ "obj-30", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-8", 0 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [ 457.5, 154.0, 439.0, 154.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-25", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-64", 0 ],
									"destination" : [ "obj-27", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-60", 0 ],
									"destination" : [ "obj-24", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-6", 0 ],
									"destination" : [ "obj-1", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-59", 1 ],
									"destination" : [ "obj-54", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-59", 4 ],
									"destination" : [ "obj-26", 0 ],
									"hidden" : 0,
									"midpoints" : [ 184.0, 171.5, 422.75, 171.5, 422.75, 103.0, 439.0, 103.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-59", 3 ],
									"destination" : [ "obj-24", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-59", 2 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [ 148.0, 173.25, 439.0, 173.25 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-59", 0 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-50", 1 ],
									"destination" : [ "obj-5", 1 ],
									"hidden" : 0,
									"midpoints" : [ 465.0, 473.5, 590.5, 473.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-50", 0 ],
									"destination" : [ "obj-47", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-49", 0 ],
									"destination" : [ "obj-62", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-48", 0 ],
									"destination" : [ "obj-3", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-47", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-46", 0 ],
									"destination" : [ "obj-40", 0 ],
									"hidden" : 0,
									"midpoints" : [ 112.0, 476.0, 131.25, 476.0, 131.25, 446.0, 150.5, 446.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-41", 0 ],
									"destination" : [ "obj-46", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-40", 0 ],
									"destination" : [ "obj-36", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-4", 0 ],
									"destination" : [ "obj-35", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-39", 0 ],
									"destination" : [ "obj-40", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-38", 0 ],
									"destination" : [ "obj-34", 2 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-36", 0 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [ 150.5, 495.0, 402.25, 495.0, 402.25, 186.0, 439.0, 186.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-35", 0 ],
									"destination" : [ "obj-62", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-34", 0 ],
									"destination" : [ "obj-64", 0 ],
									"hidden" : 0,
									"midpoints" : [ 451.5, 384.0, 607.5, 384.0, 607.5, 330.0, 542.5, 330.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-34", 0 ],
									"destination" : [ "obj-37", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-32", 0 ],
									"destination" : [ "obj-3", 2 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-31", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-30", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 3 ],
									"destination" : [ "obj-50", 0 ],
									"hidden" : 0,
									"midpoints" : [ 269.0, 656.0, 366.0, 656.0, 366.0, 451.0, 451.5, 451.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-3", 2 ],
									"destination" : [ "obj-14", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-28", 0 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-27", 0 ],
									"destination" : [ "obj-38", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-26", 0 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [ 439.0, 127.0, 439.0, 127.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 0 ],
									"destination" : [ "obj-48", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-24", 0 ],
									"destination" : [ "obj-22", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-22", 0 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [ 166.0, 251.0, 417.0, 251.0, 417.0, 186.0, 439.0, 186.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-20", 0 ],
									"destination" : [ "obj-19", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-19", 1 ],
									"destination" : [ "obj-38", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-19", 0 ],
									"destination" : [ "obj-34", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-19", 2 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [ 500.5, 325.0, 639.0, 325.0, 639.0, 187.0, 439.0, 187.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-18", 0 ],
									"destination" : [ "obj-48", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-18", 0 ],
									"destination" : [ "obj-25", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-16", 0 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [ 480.5, 178.0, 439.0, 178.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-15", 0 ],
									"destination" : [ "obj-59", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-11", 0 ],
									"destination" : [ "obj-47", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-10", 0 ],
									"destination" : [ "obj-12", 0 ],
									"hidden" : 0,
									"midpoints" : [ 167.0, 344.0, 417.0, 344.0, 417.0, 186.0, 439.0, 186.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 1 ],
									"destination" : [ "obj-13", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 2 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-29", 1 ],
									"destination" : [ "obj-31", 0 ],
									"hidden" : 0,
									"midpoints" : [ 490.0, 677.5, 651.25, 677.5, 651.25, 550.5, 498.5, 550.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-29", 0 ],
									"destination" : [ "obj-65", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-62", 0 ],
									"destination" : [ "obj-29", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-29", 2 ],
									"destination" : [ "obj-45", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-45", 0 ],
									"destination" : [ "obj-51", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"globalpatchername" : "",
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadmess clear",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontname" : "Arial",
					"patching_rect" : [ 35.0, 91.0, 91.0, 20.0 ],
					"id" : "obj-27"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "textedit",
					"text" : "testProbe6",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 4,
					"presentation_rect" : [ 311.25, 179.0, 105.0, 21.0 ],
					"bangmode" : 1,
					"outputmode" : 1,
					"outlettype" : [ "", "int", "", "" ],
					"clickmode" : 1,
					"fontname" : "Arial",
					"patching_rect" : [ 35.0, 144.0, 105.0, 21.0 ],
					"presentation" : 1,
					"id" : "obj-28",
					"keymode" : 1,
					"wordwrap" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "*Subject ID",
					"linecount" : 2,
					"fontface" : 1,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"presentation_rect" : [ 328.25, 152.0, 75.5, 20.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 57.0, 118.0, 71.0, 34.0 ],
					"presentation" : 1,
					"id" : "obj-29"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s subjid",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"color" : [ 1.0, 0.0, 1.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 35.0, 194.0, 51.0, 20.0 ],
					"id" : "obj-23"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s exp_stop",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"color" : [ 1.0, 0.0, 1.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 378.0, 175.0, 69.0, 20.0 ],
					"id" : "obj-14"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Initiate stimulus, probe times, and thresh convergence tracker",
					"linecount" : 2,
					"fontface" : 2,
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 575.0, 84.5, 178.0, 34.0 ],
					"id" : "obj-13"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "s exp_start",
					"fontsize" : 12.0,
					"numinlets" : 1,
					"numoutlets" : 0,
					"color" : [ 1.0, 0.0, 1.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 298.0, 175.0, 69.0, 20.0 ],
					"id" : "obj-10"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 378.0, 145.0, 20.0, 20.0 ],
					"id" : "obj-9"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 298.0, 145.0, 20.0, 20.0 ],
					"id" : "obj-8"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "manage_stimulus_trial",
					"text" : "p initiate_stimulus",
					"fontsize" : 12.0,
					"numinlets" : 0,
					"numoutlets" : 0,
					"color" : [ 1.0, 0.5, 0.0, 1.0 ],
					"fontname" : "Arial",
					"patching_rect" : [ 575.0, 122.5, 106.0, 20.0 ],
					"id" : "obj-1",
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 5,
							"minor" : 1,
							"revision" : 9
						}
,
						"rect" : [ 369.0, 96.0, 781.0, 696.0 ],
						"bglocked" : 0,
						"defrect" : [ 369.0, 96.0, 781.0, 696.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t i i",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "int", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 474.0, 187.0, 32.5, 20.0 ],
									"id" : "obj-40"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "+ 10",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 270.0, 138.0, 34.0, 20.0 ],
									"id" : "obj-37"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "send stim codes (11-15) to python",
									"linecount" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 269.0, 96.0, 145.0, 34.0 ],
									"id" : "obj-29"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s to_python",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 270.0, 163.0, 73.0, 20.0 ],
									"id" : "obj-32"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "send end experiment code (99) to python",
									"linecount" : 2,
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 618.0, 145.0, 126.0, 34.0 ],
									"id" : "obj-31"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s to_python",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 618.0, 188.0, 73.0, 20.0 ],
									"id" : "obj-13"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b 99",
									"fontsize" : 12.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 539.0, 152.0, 41.0, 20.0 ],
									"id" : "obj-2"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "clear",
									"fontsize" : 12.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 67.5, 597.0, 37.0, 18.0 ],
									"id" : "obj-21"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Populate names of stimuli to select from",
									"linecount" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 16.5, 52.0, 158.5, 32.0 ],
									"id" : "obj-70"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t length b clear",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "length", "bang", "clear" ],
									"fontname" : "Arial",
									"patching_rect" : [ 16.5, 115.5, 83.0, 19.0 ],
									"id" : "obj-68"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r lb",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 16.5, 90.5, 26.0, 19.0 ],
									"id" : "obj-60"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "1 prA_4_3i_1v_107bpm.wav, 2 prA_74_3i_1v_107bpm.wav, 3 prC_54_3i_1v_107bpm.wav, 4 prC_74_3i_1v_107bpm.wav, 5 prC_124_3i_1v_107bpm.wav",
									"linecount" : 5,
									"fontsize" : 10.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 48.5, 152.0, 148.0, 62.0 ],
									"id" : "obj-59"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b clear",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "clear" ],
									"fontname" : "Arial",
									"patching_rect" : [ 412.75, 107.0, 50.0, 19.0 ],
									"id" : "obj-44"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "int",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 280.75, 269.5, 31.0, 19.0 ],
									"id" : "obj-41"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r start_run",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 280.75, 233.5, 61.0, 19.0 ],
									"id" : "obj-24"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b s s",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 16.5, 333.0, 46.0, 19.0 ],
									"id" : "obj-25"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r exp_start",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 520.5, 366.0, 62.0, 19.0 ],
									"id" : "obj-12"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Ramdomly select stimulus until all have been selected ",
									"linecount" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 408.75, 52.0, 158.5, 32.0 ],
									"id" : "obj-50"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r n_stims",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 514.5, 107.0, 55.0, 19.0 ],
									"id" : "obj-49"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s n_stims",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 139.75, 333.0, 57.0, 19.0 ],
									"id" : "obj-47"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s run_num",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 441.0, 449.0, 62.0, 19.0 ],
									"id" : "obj-51"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 441.0, 395.0, 20.0, 20.0 ],
									"id" : "obj-48"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "1",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 477.75, 395.0, 33.0, 17.0 ],
									"id" : "obj-46"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "counter",
									"fontsize" : 11.0,
									"numinlets" : 5,
									"numoutlets" : 4,
									"outlettype" : [ "int", "", "", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 441.0, 422.0, 68.0, 19.0 ],
									"id" : "obj-43"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r start_run",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 430.0, 366.0, 61.0, 19.0 ],
									"id" : "obj-42"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r lb",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 492.0, 366.0, 26.0, 19.0 ],
									"id" : "obj-39"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Count runs",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"fontname" : "Arial",
									"patching_rect" : [ 441.0, 345.0, 67.0, 19.0 ],
									"id" : "obj-38"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s curr_probe_conds",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 441.0, 654.0, 108.0, 19.0 ],
									"id" : "obj-30"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "read probe_conds_attmap_v1p2.txt",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 441.0, 572.0, 184.0, 17.0 ],
									"id" : "obj-28"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "coll probe_conds",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 441.0, 627.0, 94.0, 19.0 ],
									"id" : "obj-26",
									"saved_object_attributes" : 									{
										"embed" : 0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t b i",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.5, 755.5, 43.0, 19.0 ],
									"id" : "obj-16"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl reg",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 16.5, 369.0, 37.0, 19.0 ],
									"id" : "obj-27"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r stim_dir",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 58.5, 369.0, 56.0, 19.0 ],
									"id" : "obj-19"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s stim_fpath",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 16.5, 424.0, 70.0, 19.0 ],
									"id" : "obj-9"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend store conv_msk",
									"linecount" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 73.75, 780.0, 79.0, 32.0 ],
									"id" : "obj-20"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s exp_stop",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 538.5, 187.0, 64.0, 19.0 ],
									"id" : "obj-8"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r lb",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 165.25, 780.0, 26.0, 19.0 ],
									"id" : "obj-23"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "clear",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 165.25, 808.0, 34.0, 17.0 ],
									"id" : "obj-22"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl group",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 73.75, 755.5, 50.0, 19.0 ],
									"id" : "obj-7"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "t 0",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.5, 813.0, 23.0, 19.0 ],
									"id" : "obj-5"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "uzi",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 3,
									"outlettype" : [ "bang", "bang", "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.5, 786.0, 43.0, 19.0 ],
									"id" : "obj-4"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "coll converge",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 73.75, 821.5, 75.0, 19.0 ],
									"id" : "obj-3",
									"saved_object_attributes" : 									{
										"embed" : 0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s n_probe_times",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 182.5, 654.0, 92.0, 19.0 ],
									"id" : "obj-88"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "zl len",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 138.75, 654.0, 36.0, 19.0 ],
									"id" : "obj-87"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s curr_probe_times",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.5, 654.0, 105.0, 19.0 ],
									"id" : "obj-78"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "prepend symbol",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 273.75, 597.0, 89.0, 19.0 ],
									"id" : "obj-77"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r stim_name",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 273.75, 572.0, 71.0, 19.0 ],
									"id" : "obj-76"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r lb",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 298.75, 535.0, 26.0, 19.0 ],
									"id" : "obj-75"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "coll probe_times",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.5, 627.0, 91.0, 19.0 ],
									"id" : "obj-65",
									"saved_object_attributes" : 									{
										"embed" : 0
									}

								}

							}
, 							{
								"box" : 								{
									"maxclass" : "message",
									"text" : "read probe_times_attmap_v1p2.txt",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 15.5, 572.0, 180.0, 17.0 ],
									"id" : "obj-62"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r end_run",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 478.0, 83.0, 58.0, 19.0 ],
									"id" : "obj-57"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Initialize convergence tracker ",
									"fontface" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 40.5, 721.0, 195.0, 19.0 ],
									"id" : "obj-56"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Load list of probes times and conditions associated with current stim",
									"fontface" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 139.75, 510.0, 343.0, 19.0 ],
									"id" : "obj-54"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "s stim_name",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"color" : [ 1.0, 0.0, 1.0, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 126.0, 360.0, 73.0, 19.0 ],
									"id" : "obj-10"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "sprintf symout %s%s",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 16.5, 397.0, 113.0, 19.0 ],
									"id" : "obj-35"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "route symbol",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 16.5, 305.0, 73.0, 19.0 ],
									"id" : "obj-34"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "number",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "int", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 487.0, 235.0, 50.0, 19.0 ],
									"id" : "obj-18"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "+ 1",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"fontname" : "Arial",
									"patching_rect" : [ 478.0, 162.0, 30.0, 19.0 ],
									"id" : "obj-17"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "urn",
									"fontsize" : 11.0,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "int", "bang" ],
									"fontname" : "Arial",
									"patching_rect" : [ 478.0, 135.0, 32.5, 19.0 ],
									"id" : "obj-15"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 478.0, 107.0, 20.0, 20.0 ],
									"id" : "obj-14"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "r exp_start",
									"fontsize" : 11.0,
									"numinlets" : 0,
									"numoutlets" : 1,
									"color" : [ 0.0, 1.0, 1.0, 1.0 ],
									"outlettype" : [ "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 412.75, 83.0, 62.0, 19.0 ],
									"id" : "obj-11"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Load stimulus names, randomly select and load stim audio per run",
									"linecount" : 2,
									"fontface" : 2,
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"bgcolor" : [ 0.8, 1.0, 0.8, 1.0 ],
									"fontname" : "Arial",
									"patching_rect" : [ 20.5, 8.0, 244.0, 32.0 ],
									"id" : "obj-6"
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "coll stim_names",
									"fontsize" : 11.0,
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"fontname" : "Arial",
									"patching_rect" : [ 16.5, 279.0, 89.0, 19.0 ],
									"id" : "obj-1",
									"saved_object_attributes" : 									{
										"embed" : 0
									}

								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-37", 0 ],
									"destination" : [ "obj-32", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-40", 0 ],
									"destination" : [ "obj-37", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-40", 1 ],
									"destination" : [ "obj-18", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-17", 0 ],
									"destination" : [ "obj-40", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-44", 0 ],
									"destination" : [ "obj-15", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-87", 0 ],
									"destination" : [ "obj-88", 0 ],
									"hidden" : 0,
									"midpoints" : [ 148.25, 679.0, 178.125, 679.0, 178.125, 650.0, 192.0, 650.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-87", 0 ],
									"destination" : [ "obj-7", 1 ],
									"hidden" : 0,
									"midpoints" : [ 148.25, 708.0, 247.0, 708.0, 247.0, 752.0, 114.25, 752.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-87", 0 ],
									"destination" : [ "obj-16", 0 ],
									"hidden" : 0,
									"midpoints" : [ 148.25, 709.75, 25.0, 709.75 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-77", 0 ],
									"destination" : [ "obj-65", 0 ],
									"hidden" : 0,
									"midpoints" : [ 283.25, 621.5, 25.0, 621.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-77", 0 ],
									"destination" : [ "obj-26", 0 ],
									"hidden" : 0,
									"midpoints" : [ 283.25, 621.5, 450.5, 621.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-76", 0 ],
									"destination" : [ "obj-77", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-75", 0 ],
									"destination" : [ "obj-62", 0 ],
									"hidden" : 0,
									"midpoints" : [ 308.25, 564.0, 25.0, 564.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-75", 0 ],
									"destination" : [ "obj-28", 0 ],
									"hidden" : 0,
									"midpoints" : [ 308.25, 564.0, 450.5, 564.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-7", 0 ],
									"destination" : [ "obj-20", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-68", 1 ],
									"destination" : [ "obj-59", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-68", 0 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-68", 2 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [ 90.0, 141.0, 26.0, 141.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-65", 0 ],
									"destination" : [ "obj-87", 0 ],
									"hidden" : 0,
									"midpoints" : [ 25.0, 649.5, 148.25, 649.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-65", 0 ],
									"destination" : [ "obj-78", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-62", 0 ],
									"destination" : [ "obj-65", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-60", 0 ],
									"destination" : [ "obj-68", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-59", 0 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [ 58.0, 239.5, 26.0, 239.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-57", 0 ],
									"destination" : [ "obj-14", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-5", 0 ],
									"destination" : [ "obj-7", 0 ],
									"hidden" : 0,
									"midpoints" : [ 25.0, 841.0, 62.125, 841.0, 62.125, 751.5, 83.25, 751.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-49", 0 ],
									"destination" : [ "obj-15", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-48", 0 ],
									"destination" : [ "obj-43", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-46", 0 ],
									"destination" : [ "obj-43", 2 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-46", 0 ],
									"destination" : [ "obj-43", 3 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-44", 1 ],
									"destination" : [ "obj-15", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-43", 0 ],
									"destination" : [ "obj-51", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-42", 0 ],
									"destination" : [ "obj-48", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-41", 0 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-4", 0 ],
									"destination" : [ "obj-5", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-39", 0 ],
									"destination" : [ "obj-46", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-35", 0 ],
									"destination" : [ "obj-9", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-34", 1 ],
									"destination" : [ "obj-47", 0 ],
									"hidden" : 0,
									"midpoints" : [ 80.0, 328.0, 149.25, 328.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-34", 0 ],
									"destination" : [ "obj-25", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-28", 0 ],
									"destination" : [ "obj-26", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-27", 0 ],
									"destination" : [ "obj-35", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-26", 0 ],
									"destination" : [ "obj-30", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 1 ],
									"destination" : [ "obj-35", 1 ],
									"hidden" : 0,
									"midpoints" : [ 39.5, 362.0, 120.0, 362.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 0 ],
									"destination" : [ "obj-27", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-25", 2 ],
									"destination" : [ "obj-10", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-24", 0 ],
									"destination" : [ "obj-41", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-23", 0 ],
									"destination" : [ "obj-22", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-22", 0 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [ 174.75, 834.0, 154.0, 834.0, 154.0, 815.5, 83.25, 815.5 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-21", 0 ],
									"destination" : [ "obj-65", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-20", 0 ],
									"destination" : [ "obj-3", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-19", 0 ],
									"destination" : [ "obj-27", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-18", 0 ],
									"destination" : [ "obj-41", 1 ],
									"hidden" : 0,
									"midpoints" : [ 496.5, 256.0, 302.25, 256.0 ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-16", 0 ],
									"destination" : [ "obj-4", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-16", 1 ],
									"destination" : [ "obj-4", 1 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-15", 0 ],
									"destination" : [ "obj-17", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-14", 0 ],
									"destination" : [ "obj-15", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-12", 0 ],
									"destination" : [ "obj-46", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-11", 0 ],
									"destination" : [ "obj-44", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-1", 0 ],
									"destination" : [ "obj-34", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-15", 1 ],
									"destination" : [ "obj-2", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 0 ],
									"destination" : [ "obj-8", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
, 							{
								"patchline" : 								{
									"source" : [ "obj-2", 1 ],
									"destination" : [ "obj-13", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"fontface" : 0,
						"globalpatchername" : "",
						"fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"fontname" : "Arial",
						"default_fontsize" : 12.0
					}

				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-31", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-37", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-20", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-14", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-79", 0 ],
					"destination" : [ "obj-80", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-9", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-63", 0 ],
					"destination" : [ "obj-65", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-61", 0 ],
					"destination" : [ "obj-23", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-35", 0 ],
					"destination" : [ "obj-76", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-70", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-30", 1 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [ 66.5, 418.75, 45.5, 418.75 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-30", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-28", 0 ],
					"destination" : [ "obj-61", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-30", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
