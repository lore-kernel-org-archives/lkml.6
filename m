Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65158C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0031721532
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="cA65hMfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0031721532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJUDgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:36:12 -0400
Received: from mail-eopbgr720131.outbound.protection.outlook.com ([40.107.72.131]:34720
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726507AbeJUDgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 23:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wITpjvQE3pg9xI61jGTcHZmf+4FJWCpTK/kmNe+GoNw=;
 b=cA65hMfgo9S6xvIJC6G4YIzgOh0HH68Mr67YiLJRSFWi7xDwQ1pd7e6yw3t78YFM7YdDlMS9MBe+O+JzBCQItreKTdaydvxx5YgqcbzJblYYfdIQBGrP+7XwT+SwaztC7YdmQCANBHnbDYlFQ2dJvLv/iII8vswTATkOp2J1Z4c=
Received: from BN6PR13CA0003.namprd13.prod.outlook.com (2603:10b6:404:10a::13)
 by MWHPR13MB1424.namprd13.prod.outlook.com (2603:10b6:300:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.13; Sat, 20 Oct
 2018 19:24:42 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BN6PR13CA0003.outlook.office365.com
 (2603:10b6:404:10a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.14 via Frontend
 Transport; Sat, 20 Oct 2018 19:24:42 +0000
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1250.11 via Frontend Transport; Sat, 20 Oct 2018 19:24:40 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9KJOdMt017316;
        Sat, 20 Oct 2018 19:24:40 GMT
Received: from USCULXHUB05V.am.sony.com (usculxhub05v.am.sony.com [146.215.231.43])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9KJOdLZ024991;
        Sat, 20 Oct 2018 19:24:39 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB05V.am.sony.com ([146.215.231.43]) with mapi id 14.03.0408.000; Sat,
 20 Oct 2018 15:24:39 -0400
From:   <Tim.Bird@sony.com>
To:     <gnomes@lxorguk.ukuu.org.uk>, <gregkh@linuxfoundation.org>
CC:     <ksummit-discuss@lists.linuxfoundation.org>, <mishi@linux.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the
        contact email address
Thread-Topic: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the
        contact email address
Thread-Index: AQHUaKLVEJB1QK+/RkyUhE6eSOwJJ6Uoe/qg
Date:   Sat, 20 Oct 2018 19:24:38 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF80528627@USCULXMSG01.am.sony.com>
References: <20181020134908.GA32218@kroah.com>
        <20181020135118.GG32218@kroah.com> <20181020192845.48b8b860@alans-desktop>
In-Reply-To: <20181020192845.48b8b860@alans-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(448002)(13464003)(199004)(189003)(223583001)(72206003)(126002)(486006)(85326001)(476003)(356004)(102836004)(86362001)(23726003)(6116002)(6246003)(336012)(446003)(3846002)(26005)(76176011)(426003)(6346003)(46406003)(186003)(8936002)(11346002)(50466002)(8746002)(7696005)(478600001)(4326008)(316002)(47776003)(33656002)(7736002)(2900100001)(2920100001)(55016002)(110136005)(97756001)(2906002)(86152003)(305945005)(54906003)(246002)(106466001)(229853002)(2876002)(5660300001)(55846006)(66066001)(5001870100001)(2101003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1424;H:usculsndmail03v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail03.sonyusa.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT055;1:3OJMquxI9eeovDQjD6gnLAKuTzvf3qiiaTZfdONvsuHGWWIhomjArYQmnwV+FpW2OMKi4Pd65BI5T+1Gdw+KZr6+bj0Ye8z4irwR35tkS0T1duzxx0fbs+onWzJyp2DE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcbc3ddf-85aa-4ae4-bc41-08d636c1aeff
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR13MB1424;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1424;3:rnjL1rFyeyk8bppD8nX7eaXdwG+/9SLTWqZXwhF4Wpsf5mAZw5T2zrbnKw76camz3Dp5TL6cDx9+pTSBJ7CBtlcIzQTXe1KDgbGPtUb2AphU+OjNaLlOnOSH/CByVcq1q6zwQIqXV/Gy0shtFJj9wtwbNozb9rWtwP4Bwv0/BZh9vstCK+fzwIhSjHxBm/q95CXpKsLqjWbn/z7QIvOh7yBTI5CZb1S8CVKnY2/uCV88jY/eBigxjsxtUI71ieS1R7mSt/86BZSoFrTV+5SwqUUSDarvc7ZWEPfzGp1bbxAOaiU9l4NTQmZ8UKMcn5rG+A1qjeRcQAtVNQFxkOl0YyqGQN56HVEQl0iwkHltATc=;25:TtPcF7pTY3OYcebjhLu1hcOb9mdP5POOzLHoT7GSYigg10TCPJkL6A2IU9XfexIgvfbz0Z5MZ+bE4NgAHaa8NthiHaAeRmvMaXwJc4+GQQpHeBNLx63WQcSRAkAMCaheMdDIwqvEO8a1dQHuzG7xB6XFECPP0AuMNFCs+rh/snup4tefMoPAW9XcuekCm+Dc5hkohzqxSGFQE7W1ibB0tO9wc2n/i7sjMA0ck95PLbCDC9wTSbjO0U/DdZj+xbof3q6R7ArE16WNUNxNKBZ9DR2IPewL0GnMSnSmOuDaVm4htfpf/9ClDHxUZ09boyPGFP5WtHrN/FZWo7pNVcc2kA==
X-MS-TrafficTypeDiagnostic: MWHPR13MB1424:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1424;31:zJt1oYbsyCQyYnT4wI38gUQDrTAnGm9T7jCafF0Kpc2/e6VxaVV1s4O7cctfVcNK1f6IyG+JFe+moWCCXSM/U1y1Cs0ttZzfs6Fq4lTJF9yXUaQRDffwWd8bcjUvjV5+6SwzGFExq3mpXYS+A8psP+5psoXOfYf3WToE6m1Q54oIb4A1/JgaPVz3Yvlj9KpF6VYXacDRalwAXT24WMKyITETN7k+od5z7Xf8BbYX1IQ=;20:O1XptmlZVzxgMiXYVlQuGCDlAHXKO6o2ZE0VEfqT8VG7aC1q3BCEBJxr6cxQI1OpZZAYTCbCJq932OJr841vR5min9RELEAT+4lX43wAlLk6JCr9eY3vSufD9CSLkaTYOVHxEHe0yZkcT5pedTHR/bhc/q3BexFeZnltrGQlqY6YrWTUQ5SrsvuKFEvCaNDBFnm4UgrfSMt532BPkftD05txUC/8DnxCMkDHt8eYJdLsm1w58xztDRp+yKj5C/Spgjj5qoidmzBo24vo+zBfbwGeyTtUItIxcUSeyKiPsvg4OXfvsd9E42RgTiU3ERpBsUr19Nhiwofgbeycx+QrzJ5yEVVqttUOlBXFQiCfMta+M7UcDnre8vJN7Ut5PIZv8BfQTvEm15Cp6CjQ9QIRP1luv+iFTv2RJCHlrH9BpZ9vQlkMWAnRF45cKVtZhbniD/zYsfAvpR8+6Ri8PQXpPMqKvvdNQTibYtCumvwwZtoBTi3YbtoT/42QHFan1KIf
X-Microsoft-Antispam-PRVS: <MWHPR13MB1424D0A274B358B7021F2A32FDFA0@MWHPR13MB1424.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660)(20558992708506)(209352067349851);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93003095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR13MB1424;BCL:0;PCL:0;RULEID:;SRVR:MWHPR13MB1424;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1424;4:QoDEeYlqKOy6COP2E9GqVyDrO6clIN2ZnxhHc2Lu3vMxpEO0w6N9OwGG3f3NksyDo2oKtogc+PpAudbqFe9DoyvNQ+OR7z24sQ0gp7kZA2X+nyYZ/yd/W3SHUF9xrQlKQJeMCcDvNlxZoT2mmmrcL+6L8ycGHXuqX/6ljM5eH7RL/AzSMHtTkY9L8RAvPm1Ln/NVYGpKBkJHcqUAfPPxNwlJxiZaleXatKt03rbydfs6NM5Ad5X6eXW4axfucZ5S+L8GEkmdD6tJdV+R0xwYlwzjim876o0IevhenzD7z6Y/8dMxjqM2BlhOlzLJZf5EjoUsV7cnKHXrXVqdqOA1K1UfVBEBPDhZyKIziIeImNpzd5UyQLCuyuqRBKBV6Y9w
X-Forefront-PRVS: 0831C25939
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR13MB1424;23:/cEaWuA3tn8zm2mBLPtVjO6zSJc1A0RT9GsrYMBun?=
 =?us-ascii?Q?igxPmQk1eUUohMgKWh7bC/0sWiaFiWaUmzIqA76+yIy2UtK804xa4wGYyRdn?=
 =?us-ascii?Q?qvzhfav45Sm6QV0OjI8b+XV7x8A9P0jNf/1Toevc5nw959vAjumUNr/1piYW?=
 =?us-ascii?Q?PzA1xi55iOvO9cTBtFUY11egTLze9Vlr2tr6VUsfDL/lJsx0jyhopy5xpDEk?=
 =?us-ascii?Q?SHJ03O1A1Hif6uuXi33GEcjcEITxnNRawBuTBsusiCtCq8BuG2ZqWV/eq7d6?=
 =?us-ascii?Q?zY6X8a3zACBPorbiQUbacLbls1lskRCDAlvH+FHkR2CFC/BzgF3xxd5CiCFZ?=
 =?us-ascii?Q?UCgAF08I4YFiH8yhU+0EWI9C6Kb8xo0SnIdlsIepzTMGaxx1OuPO1w7y61hb?=
 =?us-ascii?Q?HtchYd7nZ/LLb0TkSTniepa/czyIsCHhtlU5aHqpQ2/puuN41XwF9bHNhb2s?=
 =?us-ascii?Q?TBamI2UNH3EXoHAQ1NxHqV3sPSsq86JB6Agd46iV9M4eNq4FkUk44ufPVU59?=
 =?us-ascii?Q?BAKRlHzCk48RpPboQI4ywmWhVulms5vTvx6Uyv4xpDOXkdWrvDOq81bZ2T3a?=
 =?us-ascii?Q?tkcDDztRHhOukuogjWpSU3cdvgzWaBWFrSZAQ7DFGIUBc2XdTcfWez1G5WBR?=
 =?us-ascii?Q?6bzCstBMIBziwu/M5q9aslTNXrHGapSOX57Zt6Qz9g8qMSf/Z6pCXwxAL/0S?=
 =?us-ascii?Q?yctUIXrA9CMCSvFlMrzQGK3+21peTpmDdQgLhbahwJ7jqTn52TI7qBzDVzIB?=
 =?us-ascii?Q?u10zghMeWAzfuDod62T2m0c23gRxur4Pxg1kUv9ApcmJUcI2pGQvEji1QG0N?=
 =?us-ascii?Q?AxUL7wipMjL7xjAagxrRxtWgiM37khH1x3jkgLkAYcFKGbX2xM3hfYonVuOY?=
 =?us-ascii?Q?6SxoWhAK8uXXQjKTxwvvLUEyWbBVaD7zYTBap7is5jShuANU344xEaX06geW?=
 =?us-ascii?Q?04MqxAfhZj2m7jjwpKc5wI6TIM2Xdx2hSo+SuhE+PVi5NGc5+bgR+H9MypBL?=
 =?us-ascii?Q?Dwd+t6I6R1I1LU0Y8zhrsQ5UCdrlIRcO9HMgfnNS43njwD6PDdCsESBvKl5b?=
 =?us-ascii?Q?I4oJcJR1DxJjUPasy3YEE2JS6yfsDWHmedQJUi1lI0uFltD/KAiZFazMrOZJ?=
 =?us-ascii?Q?O24aQV+dRaFsuH9egenA+OWXhZAQPbMoHCqaKPR3Rga8QKdMMEJRBLCa9ZYy?=
 =?us-ascii?Q?8+zEZpOoPLGUmRoK5gC+mhBySojCevifvNKGL/NIdZ5QvPsD6YHiFdzfrvbZ?=
 =?us-ascii?Q?WnrLCij6Ei7k+yQ6iJxC+3SjJxe5j0smyOX8yTFKjXoPiNXnX59YTRhkT+PX?=
 =?us-ascii?Q?zp9sMpW3SkPxacJisGKBqK8vS+Xqq42tbzUiYbPgafQ?=
X-Microsoft-Antispam-Message-Info: xeqmndGViSdMjGRB6Tx8FI9ECbJy63t3di0BJF92LvM+h6wR4meawi6lnrgK7KR4BOSEfNLwdrdiwuKF4fdsDacfrZ2LSWH7WFpvfDGN7lncmd+2En/3UKVVKfaISJrvsx2horiCe7gmclCVHX+Ihn0lpX/tf8PPF0APWaxzmIoKqA1kqcHnpfptCM7GuSaNScU7TvtMqEqA/aVCCHJLTtmKr206HVxi2UHYj9ZL0jvsl7MQ7N2aI0NzZBOeeePLiZorrIbjQu5PKVdUYQTS1oEuaNj/6eY3fM4rlTrfOW8EJ3Qdjo7hgwgE5JdmJgUJKmusW+AHH1+daHBRw448wxgD70Sv4QjmoLZdYJnW2eQ=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1424;6:PKNXDiN5ARRFACHTCS490mXqh8a1W6iJFCwP62EMxPoMssG/5ReYcXiNc3VcbE9fvcOwpCtMyrpbgQX2Fl9EmWGiQQfmj3QbDVYvEkyVdH1a/HseA4r0VNiuckRvkuLgFmFmQi+ZKMleonHkG/zl1acYSKodh4BWBeu8gcYWDfs4CH1dvgTbLjSB9/553l2N/WUr2e1TaQ2I82ao5guWm3CPfTAFXonguHhghAudRuOyfXIQrfHeuIVREZ0j9vNs6vQoyTAnacg238eDHh+aM0wRoi+sCRWgluJdM1MFVMwAELPII1+PhoGRSeoiq0i21WJib/iDFg8OIF8yMyxRFTo+Arrd4IQXGyJqvJ2WPfAb5sbFfU8ZfMy78NOi/Z/5PcMYnmxZdkjxo5ZH5OM4ax9TP7Qtg7X8/vw1j4ZQUqj7oTApTLKY+F+Yy1ZpWswd+ZeFqywJtnLN6ZByl3aVHA==;5:Out+hj82ruRRvREw8ZEdmAPP5NlvEFzegIRx3C+JgGSZ03w1AMsHa0TTjAAyQSGHa/GW7UG16wRO2RnSINYEEpzTnfzM0H1h91D+LElM1YgWkrxsngRLZneSTXJH+d7CBZHjZh2V4J1Q+KLtkl0bLJjLbjwBJT1BQrr9hg5hywI=;7:GhDXKMS9J9DoRptWYgM6gKqImp35lkMPIlonlPGhQ6sIxVcubkHCuit8hyuiADTAtq9Dy7F+JebUKL2OhsulvhbsCpSe+zEtH4yYXUf5dvG4NFAHvPCTPTBIZf3PM7IwMOcTcOzXXJmO0b/D8ESy3qaBMQinIyjd9bC6ORDWyxuY/YE5BhB8K0ke+H73wNIHL5RLJc6AvwVOlqLBzh6W9My6cMLfmLv5/4FwgKlOJDOCUK5x/PY3+dmCle+j5/QO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2018 19:24:40.8024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbc3ddf-85aa-4ae4-bc41-08d636c1aeff
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1424
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alan Cox
>=20
> > +to the circumstances. The Code of Conduct Committee is obligated to
> > +maintain confidentiality with regard to the reporter of an incident.
> > +Further details of specific enforcement policies may be posted
> > +separately.
>=20
> Unfortunately by ignoring the other suggestions on this you've left this
> bit broken.
>=20
> The committee can't keep most stuff confidential so it's misleading and
> wrong to imply they can.

I disagree with this assessment.  We have managed to keep most stuff
confidential to the general public in the past, to the point where it has b=
een
argued that the TAB have not been transparent enough.  We're trying to
address that issue with the section about quarterly anonymized reports.

> Data protection law, reporting laws in some
> countries and the like mean that anyone expecting an incident to remain
> confidential from the person it was reported against is living in
> dreamland and are going to get a nasty shock.

OK - you seem to be talking about keeping the incident and reporter
confidential from the person reported against.
Certainly the  person reported against has to have the incident
identified to them, so that part is not confidential.  Many legal
jurisdictions require that the accused can know their accuser.
But these things come into play mostly when items have veered
into legal territory.  Most violation reports are not in the territory.
There's no legal requirement that the Code of Conduct committee
tell someone who it was that said they were rude on the mailing list.

> At the very least it should say '(except where required by law)'.

That might be a good to add.  It would be helpful, IMHO, to
re-visit the patch that's been floating around and see if it
can be added on top of this.
=20
> There is a separate issue that serious things should always go to law
> enforcement - you are setting up a policy akin to the one that got the
> catholic church and many others in trouble.
>=20
> You should also reserving the right to report serious incidents directly
> to law enforcement. Unless of course you want to be forced to sit on
> multiple reports of physical abuse from different people about
> someone - unable to tell them about each others report, unable to prove
> anything, and in twenty years time having to explain to the media why
> nothing was done.

The scope of the code of conduct basically means that it covers
online interactions (communication via mailing list, git commits
and Bugzilla).  Not to be flippant, but those are hardly mediums
that are susceptible to executing physical abuse.  Also, they are
all mediums that leave a persistent, public trail.  So I don't think the
comparison is very apt here.
 -- Tim

