class ENH_GroupMarker
{
  displayName = "$STR_ENH_GROUPMARKER_DISPLAYNAME";
  collapsed = 1;
  class Attributes
  {
    class ENH_GroupMarker_Subcategory
    {
      description = "$STR_ENH_GROUPMARKER_DESCRIPTION";
      data = "AttributeSystemSubcategory";
      control = "ENH_SubCategoryNoHeader3_Fixed";
    };
    class ENH_GroupMarker
    {
      displayName = "$STR_ENH_GROUPMARKER_DISPLAYNAME";
      tooltip = "$STR_ENH_GROUPMARKER_DESCRIPTION";
      property = "ENH_groupMarker";
      control = "ENH_GroupMarker";
      expression = "\
      if (!is3DEN && !(_value isEqualTo ['', '', '', true])) then\
      {\
        [_this, _value] spawn\
        {\
          scriptName 'ENH_Attribute_GroupMarker';\
          params ['_group', '_value'];\
          _value params ['_type', '_color', '_text', '_showGroupSize'];\
          private _leader = leader _group;\
          private _marker = createMarker\
          [\
            format ['ENH_GroupMarker_%1', str _group],\
            _leader\
          ];\
          _marker setMarkerType _type;\
          _marker setMarkerColor _color;\
          _marker setMarkerText (_text call BIS_fnc_localize);\
          while {true} do\
          {\
            sleep 1;\
            if (units _group isEqualTo []) exitWith {deleteMarker _marker};\
            if (_group getVariable ['ENH_GroupMarker_Update', true]) then\
            {\
              _marker setMarkerPos _leader;\
              if (_showGroupSize) then\
              {\
                _marker setMarkerText format ['%1 (%2)', groupId _group, count units _group];\
              };\
            };\
          };\
        };\
      };";
      defaultValue = "['', [side _this, true] call BIS_fnc_sideColor, groupID _this, true]";
    };
  };
};