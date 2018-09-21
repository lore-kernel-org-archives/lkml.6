Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C1ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F78820858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aLJxj/Qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F78820858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389547AbeIUPMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:12:52 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:53278
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbeIUPMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD/70sd+WNdp+m18iGTx+wYQ+CaXBtnQ/1LIBXLFCgU=;
 b=aLJxj/QjScOzA/vf6L9hIFy1Ys0hLwDyDcmUnBpCuo6SrNWL/onQ08lYeJAFC9fX8lqw9gOEevrbNTybFwzKpRDoHQMq9EsdPIjOO/pvDsacuxoWh4zfo9O/xb4xbo2nQlUYzR0x7IXnPpJgGbi64FCnCswGqTYf3J+vWboh6h0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suzuki.Poulose@arm.com; 
Received: from [10.4.13.23] (217.140.106.49) by
 DB7PR08MB3100.eurprd08.prod.outlook.com (2603:10a6:5:1d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 09:24:49 +0000
Subject: Re: [PATCH v2 11/11] arm: dts: ste-dbx5x0: Update coresight bindings
 for hardware port
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mathieu poirier <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        coresight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-12-suzuki.poulose@arm.com>
 <CACRpkdZ8HnbLKMcFcROa1h6+SN9zH_QKE=1LMFiiaNUmTnzV4w@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b0f36874-4af2-9537-67d6-639acf19dedf@arm.com>
Date:   Fri, 21 Sep 2018 10:24:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ8HnbLKMcFcROa1h6+SN9zH_QKE=1LMFiiaNUmTnzV4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: VI1PR0502CA0025.eurprd05.prod.outlook.com
 (2603:10a6:803:1::38) To DB7PR08MB3100.eurprd08.prod.outlook.com
 (2603:10a6:5:1d::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c166255-d1c0-4373-4225-08d61fa414b1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3100;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3100;3:/ZUls279QtuKeaJH6kL6HjURroeSQ48Dc1g24dNN6aqCWjDCp4keIOsubdDLs+VaTdEQcFfqVqdkqfZfSHM6SuJIKDJkKKHy9pGYNA8nuviWXOoYIkNhG5/uDGVL1Pz5prwxRnsoVmG87LAiwT9lMaDdR7end49dPb3INh9Mm92LWpojf/Vr5VnkVZPC9hezoWxkb2DduKWGk1sJUXbxJsH8Oc0clB9gExdB1BsdjG1IanD9F/zaycwBRaSFTJZh;25:BVn0+VB4pvlCKWfhKd4rKFrBGcYhgmlLXYXzHyZb8H1pm2L5vqficL9gjSCjF5bGrV7GD1CiYGuYItw0O45TarD8yb5tZfxi4INEIHDfIa03ob0kl/sZXX6xXffP1CfcoQGkxNwLk9rWQMQ0k8wdhMRBu9MNOJRoFZgB8ypcj+ccU25xk9FjC3so7joljS4UVwOZP5ogLPfAtJpZMP+0aXZs+VVDJ4+R5VvnYfUKmloHaWz+EzAh8HxiDOrTcAEQbAIpxJo/88wTpXDPUk1jy92r0CrNaDpZpwUzyMwHloG7mQQAs2Q6+5BsaMHxjSpRiIPz7+YjLHMEznmtFT9XTQ==;31:/uF7QvBv0MShPfadSKLcpebeqfhrTwXy7UcLrUvtcLIe4WCONdwpVyjUfO7A97Zkk/4bDNI9Q9+Zao9hMSc/plUqCthAMzTf8yu+sWov8htscBJtjwBr0t7BnXBrYWQjqFs+H58wWOIws7rCbSylN+Q4ITdXfNFDqCeJrpVmX9UxKKHu1Y7S1SYlcpvKhFnrkRWlncrg7fxHQm2eec8QDwJeQZeSnOyFp1X8V2Dlq2I=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3100:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3100;20:jXi3gvgNHNgTJR4erieia7QvmAcLH8t3iFLeacktZRbAMMumEIv99oqeXAw8amF+WNH64jWyEDA0sZa3459QXmRSGxfgLRiTTF7C2qW4S9B+oti2VMZ25jz/Inz79o5rBtcUHjZukswu9hGSsuVo5/s0fT2Ew+vFHh1Gw0lhOdU2HeU9hCeinc9g6+cIWGZEJ6zXgL+M8JTeWLla5thDxUeSQbOo0nH1eaPqlvlkILn/lnR1dkzNwFiSb65cnHUM8edFW4WYDFrW7MnD/0qWVxL/HOP2RKTc1x8B7LKuLt0ASXwoeQXi49DoB2gpJzTgi/oJQ7jy53J+TK7TpTuwkH4rdWaGKM4GjGrsYXiDE1+qrZyM6Yu1Izg3Grh7wo/1kCje2HpwGetM0IsO3C+8MXKkLpqmIWF4A3MU8CsgR+NbVgt1BBQfxVm5oT9Ui5ecqAlx8VgUsU0rrtSboZRJp9/QM+eDCVdrD4I6oCHvOi1pGD3ARRLXAsmNU+XV0ZTF;4:OMCj2XsDuJuPl+bO6mIcxkxXy3ZhrT3O/NNrSC+uGx3JX1S8AJn38m5nm9gIc+aIc1e1S2Ieed8IOl+Wihxkhbuh2nn5i5V9UQDlcS6KTzJLiuYEHvgzaTnC3Ozgt4vwFwM34DJNwL43l6gMnDgR3wUBTak7B1A/EznDUPN3ntPjjSPdbvPJ6zylJkE7iovh0C5CsoBBWfZL7QclWTvC9port9BO5GI4PxrQFMtxGubyskdG7N86LXnk8T+3hOa+VLJQiDAMIMDSLFjuVu0TIP4vlVJqwWYYO0QvmYgNqeXGdym+UOpLxLaV1oT0TDew9XjgsbsO/9D4b0l4ce/FHF4+CYpGjyoL44QxZM1aL78=
X-Microsoft-Antispam-PRVS: <DB7PR08MB31000ECFF4C78D992C83CDE291120@DB7PR08MB3100.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(12401385986421);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(2280121)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DB7PR08MB3100;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3100;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(136003)(396003)(346002)(39860400002)(366004)(40434004)(199004)(189003)(186003)(8936002)(15650500001)(53546011)(31696002)(476003)(68736007)(16526019)(65826007)(5024004)(11346002)(39060400002)(446003)(76176011)(478600001)(36756003)(97736004)(386003)(8676002)(105586002)(106356001)(72206003)(52116002)(6486002)(956004)(50466002)(66066001)(2616005)(5660300001)(31686004)(25786009)(64126003)(14444005)(53936002)(316002)(86362001)(8746002)(26005)(67846002)(52146003)(4326008)(23676004)(229853002)(47776003)(54906003)(6246003)(16576012)(65956001)(77096007)(3846002)(2486003)(2906002)(305945005)(65806001)(81156014)(486006)(81166006)(6916009)(58126008)(7736002)(6666003)(6116002)(60540400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3100;H:[10.4.13.23];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMTAwOzIzOllqbFJwOU83T3RCdnMvUy9DbFhQc3lvNFg5?=
 =?utf-8?B?NVhLQ1l4bXdYZkdkaGRUZ2xrQjJLRm5qNXdUc2ovQlR5OE1Qc1NrS3cyc0xC?=
 =?utf-8?B?cVgxTGc5NEk1MkE0WkQ5YVkvREFvUThQQ2twd296TzgvT0tKaDVoYzZhc0Nq?=
 =?utf-8?B?dTdNYXNCTEdpb1JjeEw0eENSa2lMbTh3dFdGUFFYdFVOSFNiS3BTd3FYc1dK?=
 =?utf-8?B?REx3eTdrZTVFZy9hK09xOER1WEFBWXJTMVh1WjFrZ29hd2x5S09GM0laQTdT?=
 =?utf-8?B?ZGpMN0gyV08yYlNMN1k0a3RTNmhQRnNkYWQ4Uk5RZGhJeTh0bkVWQWJQVGJG?=
 =?utf-8?B?d044TUVnNWhUbUU4SHJxU2I4MWFNMmQrRExjdFZrOFRqZGFBdWMrdTFobFVa?=
 =?utf-8?B?Rjg2bHJlVjZwcjl2dllmaUd2aGlZcGVVWW50ekNyMVZJRm5wWUJsY3FXd1pM?=
 =?utf-8?B?U01WalBZVndKUlFYMC9oQm1MMXNOek5EcFdzeEttNWo3ZlNDcXhpYjdVN0Jm?=
 =?utf-8?B?ZmJNNXY2UUpOR2NRQ0puWWpqQVhIK1pvNXVETWoxUWFqNjlCUzViZzM0Uk9x?=
 =?utf-8?B?SUVVb2YzL1JmVWVqeVZSMk5HbC85cVRMTkhmVTBwM0ZlNmc4RmRoYUJlUTBY?=
 =?utf-8?B?V1hxdElqcGs2aFdudFR4T3lMbERBTFlQMWpSSWVkdTZaSDJtWmY4R1pwQ0di?=
 =?utf-8?B?bmxMbTFrcWNRcVdleFE0RUpqekkxamlzc2sxMEc3OWFqbGpLaHVaakYvMVMr?=
 =?utf-8?B?NXpic1RwSG5ock11RDRHbFlPTzFwMmJ0NWlTa1lSM0hsQWl3dFBZOWJRUkk2?=
 =?utf-8?B?clU0emE3R2lab1I1WVIrK1lHcU5zL2w4Rmw3ZkVISzhQMGFHVWZDVitNS1RD?=
 =?utf-8?B?R2owZytXcmIyRWhUckx0YjdWTnM0M1RHaVFkY245YzAwVjBaZ1pYRzR0WWZL?=
 =?utf-8?B?cnFWWWw2WW5ZNjNFMXoranM5eDE2Q21YNC93OXRvQTVweEhGaFc2YVZoaE9P?=
 =?utf-8?B?SG01UzZYUmJDbXpDL2M4b0xhdzlVVnFFUGROUnVCdkVraEVVSkRvS204MENK?=
 =?utf-8?B?QVhmSUpiU3ZoMVdOUFY0SGtPdjBTaXRUNExZZHRpbitMMDl3L0pET1pTczc4?=
 =?utf-8?B?eFoyenJEZklJOGphMWhybFdxMmJ5NSs0TVVJTDFHckpCa0J3VFVnT0VHQzlC?=
 =?utf-8?B?UnNoLzh2V0pLVkdjUTZQb25hOTl0VmdYUXRrWDRSWUI0cTBOSlZFZGpQdm5n?=
 =?utf-8?B?MmM4ZTM4K1Qxc1RRVXN6cUI3WmRtWWZuUDN0dERSUGhkVzhOS1pnaVh4amMr?=
 =?utf-8?B?b0s0cUM4YWJQS2t2QUpPRmNjdnBUQ0k4WU1kbDk2MnpWcGdhY2FWVHRhL3ht?=
 =?utf-8?B?RnVheUd2OHRjbjBtQUtqL2RXanJxbDRFN2dMZm42NjBsajVET2NPZWNUQ3Fy?=
 =?utf-8?B?Z1Y5MmlGcnRKRVBEYnZKOENpcmp4N0Z6dXdBdVFTUnU2VEI1dHh5dHFNTGdr?=
 =?utf-8?B?emg3eDVHeTZkcVhTVVc4N2M3bHRXRTBOUGRZZXdHUFlhRmJ1dUZ6bDUrbHFB?=
 =?utf-8?B?Tjh5T3BiUXdIcFJOVkZpS0xETmhRMnZkeDRVelZtcXdJaHlkSTZUamZXSzhU?=
 =?utf-8?B?VzM2WFA1KzYzd3pGZnh1TXlwQ0NZT2ZhWHozbzh0UFhPeW44cTAwS3h6T3R2?=
 =?utf-8?B?Y1NxOEZBUm9mUWVrWldjMXpCakFOU1VKYzZMczczTG5lWFloNjkvc1VGZGY1?=
 =?utf-8?B?YkpUSHVzcXlTcUh6eHl3RlBtbkFCaDlveXBnZllYc0lnZktpbDB4aCtPVHBE?=
 =?utf-8?B?YlNZdkJKanF0ZzNNR2kyYmdPUEIybXR5K09PakppQ2NrcmsramRBdVQyaXVL?=
 =?utf-8?B?S0xPb05UREJMbng0VU5sWWdGN0xnbjVEMzBRNFJrbXRpMlN5djVDZVU0Zy9l?=
 =?utf-8?B?Wkt6Y3ZEK25YaXlkK1p1TWxqTVNQOXZxMUN1VjFxNE1JM0NVblVOMTNnYkMv?=
 =?utf-8?B?bWlUNWFJVkZsQXNpZVpYQTczMUtRQWxBYk5BWFJuYmdwR21BVEtLVlltUEhF?=
 =?utf-8?B?dThTeXNvWVlESS9kK1JOcXMxQkJxd0M0Yk1DNEFvYnNaeTh5VnRCamtOSFAy?=
 =?utf-8?B?ckJsWmRNZ3Z0ekpDc2psVzFlZzkvcjZPeFRkMlZqK1E1eTNpNWxlallVSits?=
 =?utf-8?B?cFVxSVBHNDBUeXhUbk9JRktjSE1nPT0=?=
X-Microsoft-Antispam-Message-Info: wverkQTav7AbwqAqqxG6W7WVhwIG14pDbzgp/DIxAGofAVibV86s0OL41gUFO9Ejagrf8hUkyrfRnyUdSrYeCyGixTwt/fEWaOctxBX3+209OVQm0lopRqTMc9Oxz2lpdfNBtYLNmkSx8FgGijH4cQwqZxwX7Tuge/n+010kOKTbeYCrMNTM3jCY4KJrOlVD5dtADsVUW/aWMp3XM+ONnWt9Z+AZHHlA0RMHXm/Ua+n7h2G/xMzivlYQE1RQ+3LH2JbCu+Tc/gPXF/jmAAA9hAMn7QwM7dEaxxnGL+dYQ/HOj6l14fSPA2QfX7Uu/WghAhaklaK9XJpf3qZfL0vQsQnPMrrNWEQtW2llmSkEcup5covz2I4LfINBex4H78jqLfYTOcyITeaMS+xq1C/Pg5g7bCvyt5zjFU8xenAsOkqWdw0Fk+ROqeBC65YXqsVlM8N9JkdvsxRPa6x6MeJ7OoQ6pPjFsaiwl+0dbz/3lOc=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3100;6:X8tbpPWs2Sa93/yfSW62pceK2OEdPxtl80wzUpmtJ3ALLY2Wp2HlbXFO3arGrNUSAysWs2ibrdnr+w1ST5dJ6OvvwJAu6YSY3Dzjm4Ufth95qvupTGUo0Fs8f3ZqADfut6J/UpSrjOW3hM+DclrP6fhxG4Uww7Dmz29NF6FO94H8TSwJKxNm57Y9E3LkrdUXenc+opxohaw2OmE2D7iIXVVujMe0sizcREokrxTLSJMpDy1Pc9e2J9cgSPpZs4E1Iq4Wl44UI1tbpVA/hgC2gdSHp26RayXh8Idi1ManRdNPb/2njYy2xAKSrRCcVzzZKZdQq4xqNJ78YFue5Cs9iMISZmGSWKBhApuWbeh412FsOj4Cyb6c/PJAS5pOkRfDi+ZtpGxemDExT7vD1PA3rJN9fz04ck3hryzgb+U8adD2ZELlKIZ6jyU5H9NSghw1Uz1hU2YkxUZC7zE3HGXMBw==;5:c7XUEDZFL7VSBRDghg7LD0TTKE5X7g2QXrgtVOZyLg3UrAZzV3TkPO+jfzrlrqhzMxjzOmp+Tjx2TTxmsatRPSdywSCUR3xaZeLvyQReJ/+axnjubA4A+aVzMpN5PEF5ipctLo/okPR+MbLv9DeTwfwjGo5vsptbt+ESu1xdLjw=;7:/XD3QVH5XV/3SqGZBm5IT5B1VnBIyQUHvDipJlAtNE09T1dL2w+u19lTGOzUSjMwMQFBLRx8Vw2rB8GDHLEU3dY+73N9Ddq/Nx+PoDgmYA5xYDwDtT8nxKka6OHCeE89eDaCaoiu9EBkoAv/S4mXY9JFXdIZnc/wqeeqCs7solkaabN/12CUYsLxZEtskuc3FimqOOktP9V8/2AcIPMPS+5I0p76l7end7IBzJf1Ww64kaElPsWzU++9rtPvyYFR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 09:24:49.5057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c166255-d1c0-4373-4225-08d61fa414b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On 20/09/18 23:02, Linus Walleij wrote:
> On Wed, Sep 12, 2018 at 6:54 AM Suzuki K Poulose <suzuki.poulose@arm.com>=
 wrote:
>
>> Switch to the new coresight bindings
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Applied to the ux500 tree.

Thanks !

Suzuki
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
