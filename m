Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF9ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9327F20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GcCxoGT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9327F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeKIB2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:28:06 -0500
Received: from mail-db5eur01on0084.outbound.protection.outlook.com ([104.47.2.84]:26256
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbeKIB2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10NO8qPRWDT4Z2BfavyjgoEtj+5EBrLq+Y7G2fvjmPk=;
 b=GcCxoGT2tf/ZF8FqtfFBz/TWIYNoOqs25lRcg/Nm3+KzSgXGSaABvmt2JcF6hd0Ac9lst/uN+SLGwQkdTtlLbbhu1bFo07yvIsvVwsD4642aDZJJL9JpPa81Qgsj1M4W3U6MEiFTBnMKsD6A/R6zi0xqxuB6dbo+XUYcpwtsEpE=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2861.eurprd04.prod.outlook.com (10.175.23.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Thu, 8 Nov 2018 15:51:56 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3%6]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 15:51:56 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
Thread-Topic: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
Thread-Index: AQHUdtfqCNpcjJX2bUWA1IsQb0UP1g==
Date:   Thu, 8 Nov 2018 15:51:56 +0000
Message-ID: <VI1PR0402MB3485E2C824DD151B8E482DDD98C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <e6e0105f-3135-e5b7-8224-419c9f730a09@free.fr>
 <85a73243-0c53-43e5-5002-90631c0a8c90@free.fr>
 <VI1PR0402MB3485342DB8A0F5C5791E213798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <VI1PR0402MB348569B15DBAB6503303D41798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <2ABE50FD-FF08-4E16-8D8F-A81A92722478@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2861;6:Ds9M7HYB6vfqBIAHjowEj3pjPRC35TdSykhL7yNtKy01M71buU95T16TI0fl8c/B++lJIv2scKzCjQz90egTiwCrKASg0jgoJkl28OZzF5Sihw8enY9FsrECBM4oeWbv5YOXtvGxzXZvQJx7ewQeuFkGkKe/dZrYS8sygZrYTRZilATo3u7IVtCaIgFYL+iIvxrYI5lOuaO7BGHOnkTk4gaxvLrBnLnHQ9Jk/uS7f/Xqf1O2J1DWfueZj5ZAvSAQXDqUqmtJ93Rqe+2ZqSm6Frg8rfXU2b817A8IAfM7r/6eMVW6SXnOvt+/hgFwkNqV/scuGpS2tFlk1zWTui7DtWjcIf9pu68Jy9P49k/CDqf0uPb7MQa1RcYT1yhdm2h6k6FKsrK0tB7n/F7Ea0q3r49rtT0QoVpiyJvvqsPE1N2Nyt4RXuBoiPbL4JsyNCdhE/vMWYdfUgRg5U50giHwMw==;5:frMugLmmrTKfjg1rXep0854oh5UePF21BSejaOLLDUDXvTlLF3q6GcqETIKUzRjj33dCbAeFIYYLUUBtGR3lm0ek3cSI+P7A+OAY6BsZ9TGghS11zT+7Th7wsAOTWURElpFAMWrI72A3siHHEN80skI8sNbt7ll+cFJXMQNHwSg=;7:VTa7KN9qw6uTgEi5J+m+5JnAo0XHe6p+AH7ziwF/eV8WG6bhyJNuNCDtG7TsMTqQUljS//UK+YcYktvyyB+44TUrDvjCBaK9yNeWGIFr6VmAOx1E50aGceiG2oH3lBLemrnmsAk5h3V+xhSIFSKq6A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bb830ad5-9554-4a45-708e-08d645921c6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2861;
x-ms-traffictypediagnostic: VI1PR0402MB2861:
x-microsoft-antispam-prvs: <VI1PR0402MB2861AC4EABC483570A41425598C50@VI1PR0402MB2861.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(191636701735510);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2861;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2861;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(99286004)(33656002)(74316002)(7736002)(478600001)(53936002)(9686003)(305945005)(110136005)(54906003)(316002)(55016002)(102836004)(39060400002)(14454004)(25786009)(6116002)(71200400001)(71190400001)(3846002)(6436002)(229853002)(93886005)(8936002)(81156014)(8676002)(81166006)(486006)(105586002)(4326008)(106356001)(6246003)(2900100001)(66066001)(476003)(186003)(97736004)(26005)(86362001)(44832011)(7696005)(2906002)(446003)(53546011)(5660300001)(6506007)(256004)(68736007)(76176011)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2861;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FxjDniEe852qEbq5CEbvvQ6CC/gOEebZAoqfl11q5olqnFdnvUlEmahPAgb3+5/JW5UnvcFeczGjMSy5iJeAnOzI0qpikm+R5rr0YE1JD6AsyCIxisa7WIgpf+XWy7ICZvEzs2IYt2YOy7f/Rj+sjOuTzUHMvleS2i/jygCIeayOeqqlR8MCzNcsUzTcSijnhjK0qQeotqsMinczQAcDxPqpTUtnX59cCyDkhN1h0aCOJdXF7bGo3dtvzGoSZhzi88kFpUTEaH/wcUVpY71xFzq+lzZ0cah6XdbJkSl0L0xg7EwS6W90zrGYQeLPg3EJ1yjGMK8Ar0vikSen+b/og94fX27OdKzOMWh815bwvpo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb830ad5-9554-4a45-708e-08d645921c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 15:51:56.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/2018 3:23 PM, Marc Gonzalez wrote:=0A=
> =0A=
> =0A=
> On November 8, 2018 12:38:10 PM GMT+01:00, Horia Geanta <horia.geanta@nxp=
.com> wrote:=0A=
>> On 11/8/2018 1:23 PM, Horia Geanta wrote:=0A=
>>> On 11/7/2018 10:49 PM, Marc Gonzalez wrote:=0A=
>>>> [ Add interested parties ]=0A=
>>>>=0A=
>>>> On 07/11/2018 21:18, Marc Gonzalez wrote:=0A=
>>>>=0A=
>>>>> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2=0A=
>> SoCs")=0A=
>>>>> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,=0A=
>>>>> which is not set.=0A=
>>>>>=0A=
>>> Thanks Marc.=0A=
>>>=0A=
>>> Though I would prefer enabling the dependencies:=0A=
>>> dpaa2-caam driver -> dpio driver (FSL_MC_DPIO) -> fsl-mc driver=0A=
>> (FSL_MC_BUS).=0A=
>>>=0A=
>> Could you instead incorporate below patch in your series?=0A=
>> (I am pretty sure it won't apply clean)=0A=
>>=0A=
>> Thanks,=0A=
>> Horia=0A=
>>=0A=
>> -- >8 --=0A=
>>=0A=
>> Subject: [PATCH] arm64: defconfig: enable DPAA2 fsl-mc bus and DPIO=0A=
>> driver=0A=
>>=0A=
>> Enable fsl-mc bus and DPIO (Datapath I/O) driver, which are needed on=0A=
>> Layerscape SoCs with QorIQ Data Path Acceleration Architecture (DPAA)=0A=
>> v2.=0A=
>>=0A=
>> Suggested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>=0A=
>> Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
>> ---=0A=
>> arch/arm64/configs/defconfig | 2 ++=0A=
>> 1 file changed, 2 insertions(+)=0A=
>>=0A=
>> diff --git a/arch/arm64/configs/defconfig=0A=
>> b/arch/arm64/configs/defconfig=0A=
>> index c9a57d11330b..7c3785e61ef9 100644=0A=
>> --- a/arch/arm64/configs/defconfig=0A=
>> +++ b/arch/arm64/configs/defconfig=0A=
>> @@ -181,6 +181,7 @@ CONFIG_DMA_CMA=3Dy=0A=
>> CONFIG_CMA_SIZE_MBYTES=3D32=0A=
>> CONFIG_HISILICON_LPC=3Dy=0A=
>> CONFIG_SIMPLE_PM_BUS=3Dy=0A=
>> +CONFIG_FSL_MC_BUS=3Dy=0A=
>> CONFIG_MTD=3Dy=0A=
>> CONFIG_MTD_BLOCK=3Dy=0A=
>> CONFIG_MTD_M25P80=3Dy=0A=
>> @@ -615,6 +616,7 @@ CONFIG_QCOM_IOMMU=3Dy=0A=
>> CONFIG_RPMSG_QCOM_GLINK_RPM=3Dy=0A=
>> CONFIG_RPMSG_QCOM_SMD=3Dy=0A=
>> CONFIG_RASPBERRYPI_POWER=3Dy=0A=
>> +CONFIG_FSL_MC_DPIO=3Dy=0A=
>> CONFIG_QCOM_SMEM=3Dy=0A=
>> CONFIG_QCOM_SMD_RPM=3Dy=0A=
>> CONFIG_QCOM_SMP2P=3Dy=0A=
>> -- =0A=
>> 2.16.2=0A=
> =0A=
> Are CRYPTO_DEV_FSL_DPAA2_CAAM and CONFIG_FSL_MC_DPIO required to boot the=
 platform? If not, we will build them as modules. I can send a v3 tonight w=
ith that change, as well as the various Acks.=0A=
> =0A=
No, the platform is able to boot without them, so I am ok with:=0A=
+CONFIG_FSL_MC_BUS=3Dy=0A=
+CONFIG_FSL_MC_DPIO=3Dm=0A=
-CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=3Dy=0A=
+CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=3Dm=0A=
=0A=
Thanks,=0A=
Horia=0A=
