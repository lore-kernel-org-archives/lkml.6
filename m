Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD81C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031BD2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="NH5KUHyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031BD2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeJAXgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:36:36 -0400
Received: from mail-cys01nam02on0102.outbound.protection.outlook.com ([104.47.37.102]:30702
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbeJAXgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy5dMP9yOoSuWZHjYQ1yvHhxbQtm6TdU5Yy8AbOde/I=;
 b=NH5KUHyNqabJYPiOctQLt00xh1mdUPdUXE2e2LQMk8o0Y/MGePVcJ3ruFKaYbZ3Ic6NvWwunIcCfAoMv4WFbTnMjU+LzZhwHhdgqADsMXn5a/TIMMKZHqjSjvVU9FAUtxVIUCfP+J6Iu+D2RelQIXTQUS4qKFeTp36AWPM8xxho=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1455.namprd22.prod.outlook.com (10.174.170.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 1 Oct 2018 16:57:49 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627%9]) with mapi id 15.20.1164.029; Mon, 1 Oct 2018
 16:57:49 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Joe Perches <joe@perches.com>
CC:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        linux-mips <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: MIPS/LOONGSON2 ARCHITECTURE - Use the normal
 wildcard style
Thread-Topic: [PATCH] MAINTAINERS: MIPS/LOONGSON2 ARCHITECTURE - Use the
 normal wildcard style
Thread-Index: AQHUWNm140eMuj4cxUiV2sr2DrgbeKUKng0A
Date:   Mon, 1 Oct 2018 16:57:49 +0000
Message-ID: <20181001165746.t7nqhvw5hktj2bdk@pburton-laptop>
References: <ae2126ad8eab7d87b8a13cbe75d3ba27e2df22a7.camel@perches.com>
In-Reply-To: <ae2126ad8eab7d87b8a13cbe75d3ba27e2df22a7.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR1101CA0007.namprd11.prod.outlook.com
 (2603:10b6:910:15::17) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1455;6:KFaNldsWlsonMec0GiAxAeyNeWAOiGi0A/KFwfWjbLCrGXYGsxK8IUap5JnAeTFLArRr2VGCDcNQ+UGjBCl2iAKM3sbpNACrfut99TE40FgCSStl2f55mwXwLIeBrOUOFhzRpKeXW1efwbi4DjW7VtYBS8t0k8YeYbarSVgjRsrN8xtwRDcNZTGJdkQsVobr4C5OywDORPPJPeVzBmhsF7ISGZp/PATrYRvWg2kVk1h5BKw9wzXuKRU6TAgJcT1qxy0IaNL+qSN949KUtd516xDQGFGU79x3JbYJgUJCeSILtMu14smkElfbf1mSk8V1uFnfXmSz/SePQpQ5s0Crkh2hAG8OaMT6CRtoPfZU8EsTk8045yJeW2Jai4M5IQvjAYAc1YWmVlB1t2Vyibbi757HcOYTZ7SnXyAX3yMVT2H9b88F+lwS5Sl83hsOjVGzlEPzReANt2hiTAJFY4TK/Q==;5:1WgSQCa8lUZmxg0IL1wbrqDLzsMIYsoO51AcRe2LgefUE4idUohoV3jZ09sW1oFQs6uTe534w+yThgqsdFuIE2sV2b+qLsZKL/aGXod5mUyWdAx50cpLgLdVcOk0CYR4rd2z5nLzDuGw3Ke+PP/HAN76q8wysrWUc9zKHb0neDI=;7:ikFU1G2Pn/Tbv1tCsccXXT2dO26AehE+R5/YhUGei3Gixo+4CMNEg6zuYEcx+vYhpheAE5zGAc0B87LqQWfjyUBCAulIOp0enDbefvM3yNNDYGiES2gApP3OlcC9ahE4xOq9noqMmoGUg4Whw5coeFa7sjnwYDQWiqNEEeFblwRC4AQc4RWYEePrWIbBbS/ozl+VPEQXl2dA5gfA29cpKGwSaqBBzVVBManjIhmiGcWWr8HHYeT0s8f+IiW4lQK/
x-ms-office365-filtering-correlation-id: 90ff773f-080e-4558-379c-08d627bf047a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1455;
x-ms-traffictypediagnostic: MWHPR2201MB1455:
x-microsoft-antispam-prvs: <MWHPR2201MB1455739E085341887B06420EC1EF0@MWHPR2201MB1455.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1455;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1455;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(366004)(136003)(39840400004)(396003)(189003)(199004)(33716001)(102836004)(6486002)(68736007)(6506007)(42882007)(5250100002)(53936002)(6916009)(386003)(34290500001)(229853002)(6436002)(105586002)(6246003)(106356001)(11346002)(76176011)(54906003)(316002)(97736004)(58126008)(3846002)(476003)(8676002)(1076002)(8936002)(81166006)(186003)(99286004)(26005)(33896004)(81156014)(446003)(6116002)(52116002)(71190400001)(71200400001)(44832011)(5660300001)(14444005)(256004)(2906002)(14454004)(25786009)(305945005)(9686003)(6512007)(66066001)(508600001)(2900100001)(7736002)(4326008)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1455;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k+hDis8OtnVAo+O6dsgBhASuIu0yjX5JEdsFRxUZ9D1KbbcfBwUyU/iFVT5Gkmt/rk1cPHZ8LiEcloPx/QDmKx+NFIsbzFcyZJ7Ot3ifQzTLP0j5BCJrKG6vlLX3HnjAAb8qiBRwmb/cxuw9eEthNm8FWJNdbSFspQUGC7lIbEnTFMX7vzNFrgvX+vlAoI2LQqSQUbA8r4eqeC9TKSeof02/U7xroxlk/+tVSpfcotbltfRO0POsgnR6T0cyYuNRBRHfl4Z9LpTUoBBjtyqHBSAJ4h123IKkSJs5U5yN0tWLvzjgZmliZOV5rOqTvPbGcf5uZL5rV46/PVZiNZJfHqERMI2kXWaKDTuADJkFtiY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F74004492B8C194881F500E4899EED00@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ff773f-080e-4558-379c-08d627bf047a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 16:57:49.5536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sun, Sep 30, 2018 at 09:21:34AM -0700, Joe Perches wrote:
> Neither git nor get_maintainer understands the curly brace style.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks - applied to mips-fixes, which I intend to submit a pull request
for later this week.

Paul
