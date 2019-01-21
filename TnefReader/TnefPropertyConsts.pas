unit TnefPropertyConsts;

interface

uses
  System.SysUtils;

type
  TTnefPropertyType = (
    ptUnspecified,
    ptNull,
    ptI2,
    ptLong,
    ptR4,
    ptDouble,
    ptCurrency,
    ptAppTime,
    ptError,
    ptBoolean,
    ptObject,
    ptI8,
    ptString8,
    ptUnicode,
    ptSysTime,
    ptClassId,
    ptBinary,
    ptMultiValued
  );

  TTnefPropertyId = (
    piAbDefaultDir,
    piAbDefaultPab,
    piAbProviderId,
    piAbProviders,
    piAbSearchPath,
    piAbSearchPathUpdate,
    piAccess,
    piAccessLevel,
    piAccount,
    piAcknowledgementMode,
    piAddrtype,
    piAlternateRecipient,
    piAlternateRecipientAllowed,
    piAnr,
    piAssistant,
    piAssistantTelephoneNumber,
    piAssocContentCount,
    piAttachAdditionalInfo,
    piAttachContentBase,
    piAttachContentId,
    piAttachContentLocation,
    piAttachData,
    piAttachDisposition,
    piAttachEncoding,
    piAttachExtension,
    piAttachFilename,
    piAttachFlags,
    piAttachLongFilename,
    piAttachLongPathname,
    piAttachmentX400Parameters,
    piAttachMethod,
    piAttachMimeSequence,
    piAttachMimeTag,
    piAttachNetscapeMacInfo,
    piAttachNum,
    piAttachPathname,
    piAttachRendering,
    piAttachSize,
    piAttachTag,
    piAttachTransportName,
    piAuthorizingUsers,
    piAutoForwarded,
    piAutoForwardingComment,
    piAutoResponseSuppress,
    piBeeperTelephoneNumber,
    piBirthday,
    piBody,
    piBodyContentId,
    piBodyContentLocation,
    piBodyCrc,
    piBodyHtml,
    piBusiness2TelephoneNumber,
    piBusinessAddressCity,
    piBusinessAddressCountry,
    piBusinessAddressPostalCode,
    piBusinessAddressPostOfficeBox,
    piBusinessAddressStateOrProvince,
    piBusinessAddressStreet,
    piBusinessFaxNumber,
    piBusinessHomePage,
    piCallbackTelephoneNumber,
    piCarTelephoneNumber,
    piCellularTelephoneNumber,
    piChildrensNames,
    piClientSubmitTime,
    piComment,
    piCommonViewsEntryId,
    piCompanyMainPhoneNumber,
    piCompanyName,
    piComputerNetworkName,
    piContactAddrtypes,
    piContactDefaultAddressIndex,
    piContactEmailAddresses,
    piContactEntryIds,
    piContactVersion,
    piContainerClass,
    piContainerContents,
    piContainerFlags,
    piContainerHierarchy,
    piContainerModifyVersion,
    piContentConfidentialityAlgorithmId,
    piContentCorrelator,
    piContentCount,
    piContentIdentifier,
    piContentIntegrityCheck,
    piContentLength,
    piContentReturnRequested,
    piContentsSortOrder,
    piContentUnread,
    piControlFlags,
    piControlId,
    piControlStructure,
    piControlType,
    piConversationIndex,
    piConversationKey,
    piConversationTopic,
    piConversionEits,
    piConversionProhibited,
    piConversionWithLossProhibited,
    piConvertedEits,
    piCorrelate,
    piCorrelateMtsid,
    piCountry,
    piCreateTemplates,
    piCreationTime,
    piCreationVersion,
    piCurrentVersion,
    piCustomerId,
    piDefaultProfile,
    piDefaultStore,
    piDefaultViewEntryId,
    piDefCreateDl,
    piDefCreateMailuser,
    piDeferredDeliveryTime,
    piDelegation,
    piDeleteAfterSubmit,
    piDeliverTime,
    piDeliveryPoint,
    piDeltax,
    piDeltay,
    piDepartmentName,
    piDepth,
    piDetailsTable,
    piDiscardReason,
    piDiscloseRecipients,
    piDisclosureOfRecipients,
    piDiscreteValues,
    piDiscVal,
    piDisplayBcc,
    piDisplayCc,
    piDisplayName,
    piDisplayNamePrefix,
    piDisplayTo,
    piDisplayType,
    piDlExpansionHistory,
    piDlExpansionProhibited,
    piEmailAddress,
    piEndDate,
    piEntryId,
    piExpandBeginTime,
    piExpandedBeginTime,
    piExpandedEndTime,
    piExpandEndTime,
    piExpiryTime,
    piExplicitConversion,
    piFilteringHooks,
    piFinderEntryId,
    piFolderAssociatedContents,
    piFolderType,
    piFormCategory,
    piFormCategorySub,
    piFormClsid,
    piFormContactName,
    piFormDesignerGuid,
    piFormDesignerName,
    piFormHidden,
    piFormHostMap,
    piFormMessageBehavior,
    piFormVersion,
    piFtpSite,
    piGender,
    piGeneration,
    piGivenName,
    piGovernmentIdNumber,
    piHasattach,
    piHeaderFolderEntryId,
    piHobbies,
    piHome2TelephoneNumber,
    piHomeAddressCity,
    piHomeAddressCountry,
    piHomeAddressPostalCode,
    piHomeAddressPostOfficeBox,
    piHomeAddressStateOrProvince,
    piHomeAddressStreet,
    piHomeFaxNumber,
    piHomeTelephoneNumber,
    piIcon,
    piIdentityDisplay,
    piIdentityEntryId,
    piIdentitySearchKey,
    piImplicitConversionProhibited,
    piImportance,
    piIncompleteCopy,
    piINetMailOverrideCharset,
    piINetMailOverrideFormat,
    piInitialDetailsPane,
    piInitials,
    piInReplyToId,
    piInstanceKey,
    piInternetApproved,
    piInternetArticleNumber,
    piInternetControl,
    piInternetCPID,
    piInternetDistribution,
    piInternetFollowupTo,
    piInternetLines,
    piInternetMessageId,
    piInternetNewsgroups,
    piInternetNntpPath,
    piInternetOrganization,
    piInternetPrecedence,
    piInternetReferences,
    piIpmId,
    piIpmOutboxEntryId,
    piIpmOutboxSearchKey,
    piIpmReturnRequested,
    piIpmSentmailEntryId,
    piIpmSentmailSearchKey,
    piIpmSubtreeEntryId,
    piIpmSubtreeSearchKey,
    piIpmWastebasketEntryId,
    piIpmWastebasketSearchKey,
    piIsdnNumber,
    piKeyword,
    piLanguage,
    piLanguages,
    piLastModificationTime,
    piLatestDeliveryTime,
    piListHelp,
    piListSubscribe,
    piListUnsubscribe,
    piLocality,
    piLocallyDelivered,
    piLocation,
    piLockBranchId,
    piLockDepth,
    piLockEnlistmentContext,
    piLockExpiryTime,
    piLockPersistent,
    piLockResourceDid,
    piLockResourceFid,
    piLockResourceMid,
    piLockScope,
    piLockTimeout,
    piLockType,
    piMailPermission,
    piManagerName,
    piMappingSignature,
    piMdbProvider,
    piMessageAttachments,
    piMessageCcMe,
    piMessageClass,
    piMessageCodepage,
    piMessageDeliveryId,
    piMessageDeliveryTime,
    piMessageDownloadTime,
    piMessageFlags,
    piMessageRecipients,
    piMessageRecipMe,
    piMessageSecurityLabel,
    piMessageSize,
    piMessageSubmissionId,
    piMessageToken,
    piMessageToMe,
    piMhsCommonName,
    piMiddleName,
    piMiniIcon,
    piMobileTelephoneNumber,
    piModifyVersion,
    piMsgStatus,
    piNdrDiagCode,
    piNdrReasonCode,
    piNdrStatusCode,
    piNewsgroupName,
    piNickname,
    piNntpXref,
    piNonReceiptNotificationRequested,
    piNonReceiptReason,
    piNormalizedSubject,
    piNtSecurityDescriptor,
    piNull,
    piObjectType,
    piObsoletedIpms,
    piOffice2TelephoneNumber,
    piOfficeLocation,
    piOfficeTelephoneNumber,
    piOofReplyType,
    piOrganizationalIdNumber,
    piOrigEntryId,
    piOriginalAuthorAddrtype,
    piOriginalAuthorEmailAddress,
    piOriginalAuthorEntryId,
    piOriginalAuthorName,
    piOriginalAuthorSearchKey,
    piOriginalDeliveryTime,
    piOriginalDisplayBcc,
    piOriginalDisplayCc,
    piOriginalDisplayName,
    piOriginalDisplayTo,
    piOriginalEits,
    piOriginalEntryId,
    piOriginallyIntendedRecipAddrtype,
    piOriginallyIntendedRecipEmailAddress,
    piOriginallyIntendedRecipEntryId,
    piOriginallyIntendedRecipientName,
    piOriginalSearchKey,
    piOriginalSenderAddrtype,
    piOriginalSenderEmailAddress,
    piOriginalSenderEntryId,
    piOriginalSenderName,
    piOriginalSenderSearchKey,
    piOriginalSensitivity,
    piOriginalSentRepresentingAddrtype,
    piOriginalSentRepresentingEmailAddress,
    piOriginalSentRepresentingEntryId,
    piOriginalSentRepresentingName,
    piOriginalSentRepresentingSearchKey,
    piOriginalSubject,
    piOriginalSubmitTime,
    piOriginatingMtaCertificate,
    piOriginatorAndDlExpansionHistory,
    piOriginatorCertificate,
    piOriginatorDeliveryReportRequested,
    piOriginatorNonDeliveryReportRequested,
    piOriginatorRequestedAlternateRecipient,
    piOriginatorReturnAddress,
    piOriginCheck,
    piOrigMessageClass,
    piOtherAddressCity,
    piOtherAddressCountry,
    piOtherAddressPostalCode,
    piOtherAddressPostOfficeBox,
    piOtherAddressStateOrProvince,
    piOtherAddressStreet,
    piOtherTelephoneNumber,
    piOwnerApptId,
    piOwnStoreEntryId,
    piPagerTelephoneNumber,
    piParentDisplay,
    piParentEntryId,
    piParentKey,
    piPersonalHomePage,
    piPhysicalDeliveryBureauFaxDelivery,
    piPhysicalDeliveryMode,
    piPhysicalDeliveryReportRequest,
    piPhysicalForwardingAddress,
    piPhysicalForwardingAddressRequested,
    piPhysicalForwardingProhibited,
    piPhysicalRenditionAttributes,
    piPostalAddress,
    piPostalCode,
    piPostFolderEntries,
    piPostFolderNames,
    piPostOfficeBox,
    piPostReplyDenied,
    piPostReplyFolderEntries,
    piPostReplyFolderNames,
    piPreferredByName,
    piPreprocess,
    piPrimaryCapability,
    piPrimaryFaxNumber,
    piPrimaryTelephoneNumber,
    piPriority,
    piProfession,
    piProfileName,
    piProofOfDelivery,
    piProofOfDeliveryRequested,
    piProofOfSubmission,
    piProofOfSubmissionRequested,
    piPropIdSecureMax,
    piPropIdSecureMin,
    piProviderDisplay,
    piProviderDllName,
    piProviderOrdinal,
    piProviderSubmitTime,
    piProviderUid,
    piPuid,
    piRadioTelephoneNumber,
    piRcvdRepresentingAddrtype,
    piRcvdRepresentingEmailAddress,
    piRcvdRepresentingEntryId,
    piRcvdRepresentingName,
    piRcvdRepresentingSearchKey,
    piReadReceiptEntryId,
    piReadReceiptRequested,
    piReadReceiptSearchKey,
    piReceiptTime,
    piReceivedByAddrtype,
    piReceivedByEmailAddress,
    piReceivedByEntryId,
    piReceivedByName,
    piReceivedBySearchKey,
    piReceiveFolderSettings,
    piRecipientCertificate,
    piRecipientNumberForAdvice,
    piRecipientReassignmentProhibited,
    piRecipientStatus,
    piRecipientType,
    piRecordKey,
    piRedirectionHistory,
    piReferredByName,
    piRegisteredMailType,
    piRelatedIpms,
    piRemoteProgress,
    piRemoteProgressText,
    piRemoteValidateOk,
    piRenderingPosition,
    piReplyRecipientEntries,
    piReplyRecipientNames,
    piReplyRequested,
    piReplyTime,
    piReportEntryId,
    piReportingDlName,
    piReportingMtaCertificate,
    piReportName,
    piReportSearchKey,
    piReportTag,
    piReportText,
    piReportTime,
    piRequestedDeliveryMethod,
    piResourceFlags,
    piResourceMethods,
    piResourcePath,
    piResourceType,
    piResponseRequested,
    piResponsibility,
    piReturnedIpm,
    piRowid,
    piRowType,
    piRtfCompressed,
    piRtfInSync,
    piRtfSyncBodyCount,
    piRtfSyncBodyCrc,
    piRtfSyncBodyTag,
    piRtfSyncPrefixCount,
    piRtfSyncTrailingCount,
    piSearch,
    piSearchKey,
    piSecurity,
    piSelectable,
    piSenderAddrtype,
    piSenderEmailAddress,
    piSenderEntryId,
    piSenderName,
    piSenderSearchKey,
    piSendInternetEncoding,
    piSendRecallReport,
    piSendRichInfo,
    piSensitivity,
    piSentmailEntryId,
    piSentRepresentingAddrtype,
    piSentRepresentingEmailAddress,
    piSentRepresentingEntryId,
    piSentRepresentingName,
    piSentRepresentingSearchKey,
    piServiceDeleteFiles,
    piServiceDllName,
    piServiceEntryName,
    piServiceExtraUids,
    piServiceName,
    piServices,
    piServiceSupportFiles,
    piServiceUid,
    piSevenBitDisplayName,
    piSmtpAddress,
    piSpoolerStatus,
    piSpouseName,
    piStartDate,
    piStateOrProvince,
    piStatus,
    piStatusCode,
    piStatusString,
    piStoreEntryId,
    piStoreProviders,
    piStoreRecordKey,
    piStoreState,
    piStoreSupportMask,
    piStreetAddress,
    piSubfolders,
    piSubject,
    piSubjectIpm,
    piSubjectPrefix,
    piSubmitFlags,
    piSupersedes,
    piSupplementaryInfo,
    piSurname,
    piTelexNumber,
    piTemplateid,
    piTitle,
    piTnefCorrelationKey,
    piTransmitableDisplayName,
    piTransportKey,
    piTransportMessageHeaders,
    piTransportProviders,
    piTransportStatus,
    piTtytddPhoneNumber,
    piTypeOfMtsUser,
    piUserCertificate,
    piUserX509Certificate,
    piValidFolderMask,
    piViewsEntryId,
    piWeddingAnniversary,
    piX400ContentType,
    piX400DeferredDeliveryCancel,
    piXpos,
    piYpos
  );

const
  TnefPropertyTypes: array[TTnefPropertyType] of SmallInt = (
    0, //ptUnspecified
    1, //ptNull
    2, //ptI2
    3, //ptLong
    4, //ptR4
    5, //ptDouble
    6, //ptCurrency
    7, //ptAppTime
    10, //ptError
    11, //ptBoolean
    13, //ptObject
    20, //ptI8
    30, //ptString8
    31, //ptUnicode
    64, //ptSysTime
    72, //ptClassId
    258, //ptBinary
    4096 //ptMultiValued
  );

  TnefPropertyIds: array[TTnefPropertyId] of SmallInt = (
    $3D06, //piAbDefaultDir
    $3D07, //piAbDefaultPab
    $3615, //piAbProviderId
    $3D01, //piAbProviders
    $3D05, //piAbSearchPath
    $3D11, //piAbSearchPathUpdate
    $0FF4, //piAccess
    $0FF7, //piAccessLevel
    $3A00, //piAccount
    $0001, //piAcknowledgementMode
    $3002, //piAddrtype
    $3A01, //piAlternateRecipient
    $0002, //piAlternateRecipientAllowed
    $360C, //piAnr
    $3A30, //piAssistant
    $3A2E, //piAssistantTelephoneNumber
    $3617, //piAssocContentCount
    $370F, //piAttachAdditionalInfo
    $3711, //piAttachContentBase
    $3712, //piAttachContentId
    $3713, //piAttachContentLocation
    $3701, //piAttachData
    $3716, //piAttachDisposition
    $3702, //piAttachEncoding
    $3703, //piAttachExtension
    $3704, //piAttachFilename
    $3714, //piAttachFlags
    $3707, //piAttachLongFilename
    $370D, //piAttachLongPathname
    $3700, //piAttachmentX400Parameters
    $3705, //piAttachMethod
    $3710, //piAttachMimeSequence
    $370E, //piAttachMimeTag
    $3715, //piAttachNetscapeMacInfo
    $0E21, //piAttachNum
    $3708, //piAttachPathname
    $3709, //piAttachRendering
    $0E20, //piAttachSize
    $370A, //piAttachTag
    $370C, //piAttachTransportName
    $0003, //piAuthorizingUsers
    $0005, //piAutoForwarded
    $0004, //piAutoForwardingComment
    $3FDF, //piAutoResponseSuppress
    $3A21, //piBeeperTelephoneNumber
    $3A42, //piBirthday
    $1000, //piBody
    $1015, //piBodyContentId
    $1014, //piBodyContentLocation
    $0E1C, //piBodyCrc
    $1013, //piBodyHtml
    $3A1B, //piBusiness2TelephoneNumber
    $3A27, //piBusinessAddressCity
    $3A26, //piBusinessAddressCountry
    $3A2A, //piBusinessAddressPostalCode
    $3A2B, //piBusinessAddressPostOfficeBox
    $3A28, //piBusinessAddressStateOrProvince
    $3A29, //piBusinessAddressStreet
    $3A24, //piBusinessFaxNumber
    $3A51, //piBusinessHomePage
    $3A02, //piCallbackTelephoneNumber
    $3A1E, //piCarTelephoneNumber
    $3A1C, //piCellularTelephoneNumber
    $3A58, //piChildrensNames
    $0039, //piClientSubmitTime
    $3004, //piComment
    $35E6, //piCommonViewsEntryId
    $3A57, //piCompanyMainPhoneNumber
    $3A16, //piCompanyName
    $3A49, //piComputerNetworkName
    $3A54, //piContactAddrtypes
    $3A55, //piContactDefaultAddressIndex
    $3A56, //piContactEmailAddresses
    $3A53, //piContactEntryIds
    $3A52, //piContactVersion
    $3613, //piContainerClass
    $360F, //piContainerContents
    $3600, //piContainerFlags
    $360E, //piContainerHierarchy
    $3614, //piContainerModifyVersion
    $0006, //piContentConfidentialityAlgorithmId
    $0007, //piContentCorrelator
    $3602, //piContentCount
    $0008, //piContentIdentifier
    $0C00, //piContentIntegrityCheck
    $0009, //piContentLength
    $000A, //piContentReturnRequested
    $360D, //piContentsSortOrder
    $3603, //piContentUnread
    $3F00, //piControlFlags
    $3F07, //piControlId
    $3F01, //piControlStructure
    $3F02, //piControlType
    $0071, //piConversationIndex
    $000B, //piConversationKey
    $0070, //piConversationTopic
    $000C, //piConversionEits
    $3A03, //piConversionProhibited
    $000D, //piConversionWithLossProhibited
    $000E, //piConvertedEits
    $0E0C, //piCorrelate
    $0E0D, //piCorrelateMtsid
    $3A26, //piCountry
    $3604, //piCreateTemplates
    $3007, //piCreationTime
    $0E19, //piCreationVersion
    $0E00, //piCurrentVersion
    $3A4A, //piCustomerId
    $3D04, //piDefaultProfile
    $3400, //piDefaultStore
    $3616, //piDefaultViewEntryId
    $3611, //piDefCreateDl
    $3612, //piDefCreateMailuser
    $000F, //piDeferredDeliveryTime
    $007E, //piDelegation
    $0E01, //piDeleteAfterSubmit
    $0010, //piDeliverTime
    $0C07, //piDeliveryPoint
    $3F03, //piDeltax
    $3F04, //piDeltay
    $3A18, //piDepartmentName
    $3005, //piDepth
    $3605, //piDetailsTable
    $0011, //piDiscardReason
    $3A04, //piDiscloseRecipients
    $0012, //piDisclosureOfRecipients
    $0E0E, //piDiscreteValues
    $004A, //piDiscVal
    $0E02, //piDisplayBcc
    $0E03, //piDisplayCc
    $3001, //piDisplayName
    $3A45, //piDisplayNamePrefix
    $0E04, //piDisplayTo
    $3900, //piDisplayType
    $0013, //piDlExpansionHistory
    $0014, //piDlExpansionProhibited
    $3003, //piEmailAddress
    $0061, //piEndDate
    $0FFF, //piEntryId
    $3618, //piExpandBeginTime
    $361A, //piExpandedBeginTime
    $361B, //piExpandedEndTime
    $3619, //piExpandEndTime
    $0015, //piExpiryTime
    $0C01, //piExplicitConversion
    $3D08, //piFilteringHooks
    $35E7, //piFinderEntryId
    $3610, //piFolderAssociatedContents
    $3601, //piFolderType
    $3304, //piFormCategory
    $3305, //piFormCategorySub
    $3302, //piFormClsid
    $3303, //piFormContactName
    $3309, //piFormDesignerGuid
    $3308, //piFormDesignerName
    $3307, //piFormHidden
    $3306, //piFormHostMap
    $330A, //piFormMessageBehavior
    $3301, //piFormVersion
    $3A4C, //piFtpSite
    $3A4D, //piGender
    $3A05, //piGeneration
    $3A06, //piGivenName
    $3A07, //piGovernmentIdNumber
    $0E1B, //piHasattach
    $3E0A, //piHeaderFolderEntryId
    $3A43, //piHobbies
    $3A2F, //piHome2TelephoneNumber
    $3A59, //piHomeAddressCity
    $3A5A, //piHomeAddressCountry
    $3A5B, //piHomeAddressPostalCode
    $3A5E, //piHomeAddressPostOfficeBox
    $3A5C, //piHomeAddressStateOrProvince
    $3A5D, //piHomeAddressStreet
    $3A25, //piHomeFaxNumber
    $3A09, //piHomeTelephoneNumber
    $0FFD, //piIcon
    $3E00, //piIdentityDisplay
    $3E01, //piIdentityEntryId
    $3E05, //piIdentitySearchKey
    $0016, //piImplicitConversionProhibited
    $0017, //piImportance
    $0035, //piIncompleteCopy
    $5903, //piINetMailOverrideCharset
    $5902, //piINetMailOverrideFormat
    $3F08, //piInitialDetailsPane
    $3A0A, //piInitials
    $1042, //piInReplyToId
    $0FF6, //piInstanceKey
    $1030, //piInternetApproved
    $0E23, //piInternetArticleNumber
    $1031, //piInternetControl
    $3FDE, //piInternetCPID
    $1032, //piInternetDistribution
    $1033, //piInternetFollowupTo
    $1034, //piInternetLines
    $1035, //piInternetMessageId
    $1036, //piInternetNewsgroups
    $1038, //piInternetNntpPath
    $1037, //piInternetOrganization
    $1041, //piInternetPrecedence
    $1039, //piInternetReferences
    $0018, //piIpmId
    $35E2, //piIpmOutboxEntryId
    $3411, //piIpmOutboxSearchKey
    $0C02, //piIpmReturnRequested
    $35E4, //piIpmSentmailEntryId
    $3413, //piIpmSentmailSearchKey
    $35E0, //piIpmSubtreeEntryId
    $3410, //piIpmSubtreeSearchKey
    $35E3, //piIpmWastebasketEntryId
    $3412, //piIpmWastebasketSearchKey
    $3A2D, //piIsdnNumber
    $3A0B, //piKeyword
    $3A0C, //piLanguage
    $002F, //piLanguages
    $3008, //piLastModificationTime
    $0019, //piLatestDeliveryTime
    $1043, //piListHelp
    $1044, //piListSubscribe
    $1045, //piListUnsubscribe
    $3A27, //piLocality
    $6745, //piLocallyDelivered
    $3A0D, //piLocation
    $3800, //piLockBranchId
    $3808, //piLockDepth
    $3804, //piLockEnlistmentContext
    $380A, //piLockExpiryTime
    $3807, //piLockPersistent
    $3802, //piLockResourceDid
    $3801, //piLockResourceFid
    $3803, //piLockResourceMid
    $3806, //piLockScope
    $3809, //piLockTimeout
    $3805, //piLockType
    $3A0E, //piMailPermission
    $3A4E, //piManagerName
    $0FF8, //piMappingSignature
    $3414, //piMdbProvider
    $0E13, //piMessageAttachments
    $0058, //piMessageCcMe
    $001A, //piMessageClass
    $3FFD, //piMessageCodepage
    $001B, //piMessageDeliveryId
    $0E06, //piMessageDeliveryTime
    $0E18, //piMessageDownloadTime
    $0E07, //piMessageFlags
    $0E12, //piMessageRecipients
    $0059, //piMessageRecipMe
    $001E, //piMessageSecurityLabel
    $0E08, //piMessageSize
    $0047, //piMessageSubmissionId
    $0C03, //piMessageToken
    $0057, //piMessageToMe
    $3A0F, //piMhsCommonName
    $3A44, //piMiddleName
    $0FFC, //piMiniIcon
    $3A1C, //piMobileTelephoneNumber
    $0E1A, //piModifyVersion
    $0E17, //piMsgStatus
    $0C05, //piNdrDiagCode
    $0C04, //piNdrReasonCode
    $0C20, //piNdrStatusCode
    $0E24, //piNewsgroupName
    $3A4F, //piNickname
    $1040, //piNntpXref
    $0C06, //piNonReceiptNotificationRequested
    $003E, //piNonReceiptReason
    $0E1D, //piNormalizedSubject
    $0E27, //piNtSecurityDescriptor
    $0000, //piNull
    $0FFE, //piObjectType
    $001F, //piObsoletedIpms
    $3A1B, //piOffice2TelephoneNumber
    $3A19, //piOfficeLocation
    $3A08, //piOfficeTelephoneNumber
    $4080, //piOofReplyType
    $3A10, //piOrganizationalIdNumber
    $300F, //piOrigEntryId
    $0079, //piOriginalAuthorAddrtype
    $007A, //piOriginalAuthorEmailAddress
    $004C, //piOriginalAuthorEntryId
    $004D, //piOriginalAuthorName
    $0056, //piOriginalAuthorSearchKey
    $0055, //piOriginalDeliveryTime
    $0072, //piOriginalDisplayBcc
    $0073, //piOriginalDisplayCc
    $3A13, //piOriginalDisplayName
    $0074, //piOriginalDisplayTo
    $0021, //piOriginalEits
    $3A12, //piOriginalEntryId
    $007B, //piOriginallyIntendedRecipAddrtype
    $007C, //piOriginallyIntendedRecipEmailAddress
    $1012, //piOriginallyIntendedRecipEntryId
    $0020, //piOriginallyIntendedRecipientName
    $3A14, //piOriginalSearchKey
    $0066, //piOriginalSenderAddrtype
    $0067, //piOriginalSenderEmailAddress
    $005B, //piOriginalSenderEntryId
    $005A, //piOriginalSenderName
    $005C, //piOriginalSenderSearchKey
    $002E, //piOriginalSensitivity
    $0068, //piOriginalSentRepresentingAddrtype
    $0069, //piOriginalSentRepresentingEmailAddress
    $005E, //piOriginalSentRepresentingEntryId
    $005D, //piOriginalSentRepresentingName
    $005F, //piOriginalSentRepresentingSearchKey
    $0049, //piOriginalSubject
    $004E, //piOriginalSubmitTime
    $0E25, //piOriginatingMtaCertificate
    $1002, //piOriginatorAndDlExpansionHistory
    $0022, //piOriginatorCertificate
    $0023, //piOriginatorDeliveryReportRequested
    $0C08, //piOriginatorNonDeliveryReportRequested
    $0C09, //piOriginatorRequestedAlternateRecipient
    $0024, //piOriginatorReturnAddress
    $0027, //piOriginCheck
    $004B, //piOrigMessageClass
    $3A5F, //piOtherAddressCity
    $3A60, //piOtherAddressCountry
    $3A61, //piOtherAddressPostalCode
    $3A64, //piOtherAddressPostOfficeBox
    $3A62, //piOtherAddressStateOrProvince
    $3A63, //piOtherAddressStreet
    $3A1F, //piOtherTelephoneNumber
    $0062, //piOwnerApptId
    $3E06, //piOwnStoreEntryId
    $3A21, //piPagerTelephoneNumber
    $0E05, //piParentDisplay
    $0E09, //piParentEntryId
    $0025, //piParentKey
    $3A50, //piPersonalHomePage
    $0C0A, //piPhysicalDeliveryBureauFaxDelivery
    $0C0B, //piPhysicalDeliveryMode
    $0C0C, //piPhysicalDeliveryReportRequest
    $0C0D, //piPhysicalForwardingAddress
    $0C0E, //piPhysicalForwardingAddressRequested
    $0C0F, //piPhysicalForwardingProhibited
    $0C10, //piPhysicalRenditionAttributes
    $3A15, //piPostalAddress
    $3A2A, //piPostalCode
    $103B, //piPostFolderEntries
    $103C, //piPostFolderNames
    $3A2B, //piPostOfficeBox
    $103F, //piPostReplyDenied
    $103D, //piPostReplyFolderEntries
    $103E, //piPostReplyFolderNames
    $3A47, //piPreferredByName
    $0E22, //piPreprocess
    $3904, //piPrimaryCapability
    $3A23, //piPrimaryFaxNumber
    $3A1A, //piPrimaryTelephoneNumber
    $0026, //piPriority
    $3A46, //piProfession
    $3D12, //piProfileName
    $0C11, //piProofOfDelivery
    $0C12, //piProofOfDeliveryRequested
    $0E26, //piProofOfSubmission
    $0028, //piProofOfSubmissionRequested
    $67FF, //piPropIdSecureMax
    $67F0, //piPropIdSecureMin
    $3006, //piProviderDisplay
    $300A, //piProviderDllName
    $300D, //piProviderOrdinal
    $0048, //piProviderSubmitTime
    $300C, //piProviderUid
    $300E, //piPuid
    $3A1D, //piRadioTelephoneNumber
    $0077, //piRcvdRepresentingAddrtype
    $0078, //piRcvdRepresentingEmailAddress
    $0043, //piRcvdRepresentingEntryId
    $0044, //piRcvdRepresentingName
    $0052, //piRcvdRepresentingSearchKey
    $0046, //piReadReceiptEntryId
    $0029, //piReadReceiptRequested
    $0053, //piReadReceiptSearchKey
    $002A, //piReceiptTime
    $0075, //piReceivedByAddrtype
    $0076, //piReceivedByEmailAddress
    $003F, //piReceivedByEntryId
    $0040, //piReceivedByName
    $0051, //piReceivedBySearchKey
    $3415, //piReceiveFolderSettings
    $0C13, //piRecipientCertificate
    $0C14, //piRecipientNumberForAdvice
    $002B, //piRecipientReassignmentProhibited
    $0E15, //piRecipientStatus
    $0C15, //piRecipientType
    $0FF9, //piRecordKey
    $002C, //piRedirectionHistory
    $3A47, //piReferredByName
    $0C16, //piRegisteredMailType
    $002D, //piRelatedIpms
    $3E0B, //piRemoteProgress
    $3E0C, //piRemoteProgressText
    $3E0D, //piRemoteValidateOk
    $370B, //piRenderingPosition
    $004F, //piReplyRecipientEntries
    $0050, //piReplyRecipientNames
    $0C17, //piReplyRequested
    $0030, //piReplyTime
    $0045, //piReportEntryId
    $1003, //piReportingDlName
    $1004, //piReportingMtaCertificate
    $003A, //piReportName
    $0054, //piReportSearchKey
    $0031, //piReportTag
    $1001, //piReportText
    $0032, //piReportTime
    $0C18, //piRequestedDeliveryMethod
    $3009, //piResourceFlags
    $3E02, //piResourceMethods
    $3E07, //piResourcePath
    $3E03, //piResourceType
    $0063, //piResponseRequested
    $0E0F, //piResponsibility
    $0033, //piReturnedIpm
    $3000, //piRowid
    $0FF5, //piRowType
    $1009, //piRtfCompressed
    $0E1F, //piRtfInSync
    $1007, //piRtfSyncBodyCount
    $1006, //piRtfSyncBodyCrc
    $1008, //piRtfSyncBodyTag
    $1010, //piRtfSyncPrefixCount
    $1011, //piRtfSyncTrailingCount
    $3607, //piSearch
    $300B, //piSearchKey
    $0034, //piSecurity
    $3609, //piSelectable
    $0C1E, //piSenderAddrtype
    $0C1F, //piSenderEmailAddress
    $0C19, //piSenderEntryId
    $0C1A, //piSenderName
    $0C1D, //piSenderSearchKey
    $3A71, //piSendInternetEncoding
    $6803, //piSendRecallReport
    $3A40, //piSendRichInfo
    $0036, //piSensitivity
    $0E0A, //piSentmailEntryId
    $0064, //piSentRepresentingAddrtype
    $0065, //piSentRepresentingEmailAddress
    $0041, //piSentRepresentingEntryId
    $0042, //piSentRepresentingName
    $003B, //piSentRepresentingSearchKey
    $3D10, //piServiceDeleteFiles
    $3D0A, //piServiceDllName
    $3D0B, //piServiceEntryName
    $3D0D, //piServiceExtraUids
    $3D09, //piServiceName
    $3D0E, //piServices
    $3D0F, //piServiceSupportFiles
    $3D0C, //piServiceUid
    $39FF, //piSevenBitDisplayName
    $39FE, //piSmtpAddress
    $0E10, //piSpoolerStatus
    $3A48, //piSpouseName
    $0060, //piStartDate
    $3A28, //piStateOrProvince
    $360B, //piStatus
    $3E04, //piStatusCode
    $3E08, //piStatusString
    $0FFB, //piStoreEntryId
    $3D00, //piStoreProviders
    $0FFA, //piStoreRecordKey
    $340E, //piStoreState
    $340D, //piStoreSupportMask
    $3A29, //piStreetAddress
    $360A, //piSubfolders
    $0037, //piSubject
    $0038, //piSubjectIpm
    $003D, //piSubjectPrefix
    $0E14, //piSubmitFlags
    $103A, //piSupersedes
    $0C1B, //piSupplementaryInfo
    $3A11, //piSurname
    $3A2C, //piTelexNumber
    $3902, //piTemplateid
    $3A17, //piTitle
    $007F, //piTnefCorrelationKey
    $3A20, //piTransmitableDisplayName
    $0E16, //piTransportKey
    $007D, //piTransportMessageHeaders
    $3D02, //piTransportProviders
    $0E11, //piTransportStatus
    $3A4B, //piTtytddPhoneNumber
    $0C1C, //piTypeOfMtsUser
    $3A22, //piUserCertificate
    $3A70, //piUserX509Certificate
    $35DF, //piValidFolderMask
    $35E5, //piViewsEntryId
    $3A41, //piWeddingAnniversary
    $003C, //piX400ContentType
    $3E09, //piX400DeferredDeliveryCancel
    $3F05, //piXpos
    $3F06 //piYpos
  );

function GetTnefPropertyType(AType: SmallInt): TTnefPropertyType;
function GetTnefPropertyId(AId: SmallInt): TTnefPropertyId;

implementation

function GetTnefPropertyType(AType: SmallInt): TTnefPropertyType;
var
  i: TTnefPropertyType;
begin
  for i := Low(TTnefPropertyType) to High(TTnefPropertyType) do
  begin
    if (TnefPropertyTypes[i] = AType) then
    begin
      Exit(i);
    end;
  end;

  Exit(ptUnspecified);
end;

function GetTnefPropertyId(AId: SmallInt): TTnefPropertyId;
var
  i: TTnefPropertyId;
begin
  for i := Low(TTnefPropertyId) to High(TTnefPropertyId) do
  begin
    if (TnefPropertyIds[i] = AId) then
    begin
      Exit(i);
    end;
  end;

  Exit(piNull);
end;

end.

