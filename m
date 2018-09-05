Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D85C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CCB2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="es5Z17U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CCB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeIEGuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:50:51 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:7235
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbeIEGuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9HKC6XHcq1Jxsbh6x9bllOqkVUG6hwIJtlTgyGDNfE=;
 b=es5Z17U+EOgw14dxSqWG1kzlf4BeM4DJaapcPr6lHZPGyxEcUVzCOm+jruq/N39Xyxic2fkdGpCpdEQyM3WDIUQURE3aRzJylS4XVDUx9/+aJ3ZHy7omykw+8/+g8gU4gqIVCpzfVvhOdWAqoJ2d6hbMhwBTQhkOoOw3DuJXG24=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2803.eurprd04.prod.outlook.com (10.175.41.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Wed, 5 Sep 2018 02:22:55 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766%8]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 02:22:55 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
Thread-Topic: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
Thread-Index: AQHUQN58VHTeiUfa70eLJzpyIbtKMKTfWooAgAGh2AA=
Date:   Wed, 5 Sep 2018 02:22:55 +0000
Message-ID: <AM5PR0402MB28659BF8C2B5B3B18DB6BAC9F1020@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-2-ran.wang_1@nxp.com>
 <5b8e8a71.1c69fb81.d966f.1ca1@mx.google.com>
In-Reply-To: <5b8e8a71.1c69fb81.d966f.1ca1@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2803;6:vhHjO+d5BLWCWpk83l1ygFN6a08+dTcx8IH+lSLTuXpuOb/SE+XEkMUngBKXv2yWF+QQ01oD9qFCG1fyPsFnu3NWVlokPFWhKDDwpIwzWX92shnGOJD6tkugKxw3JHY7/CRTtfzGg9vo54YAJRsArkAqWV65hOtrNo8GvShRzkW5v8fi9XWwGKI9oESGZWNM6js1OEMxXK5zjmz+n9GyxRsGKSqIBYHp2uuJ2HhUUlUPdX7XikOWYyV5Zm1bv3KbMd2yMjML/g1Jeqsh5HSFwIIopEgCybNxlq81AdciJ2KbQG5gNhotEwiI66kPf0Ddw8PibmcqDYwDLOqqQ6J4S5zkzbgt6osTPFuzqjk4pyvI9Ok3EGYFT1xk5x9ezvcta2paS/3QDLE2HB1Z7QdsL1k5G194OULgcuPljIQriKP7YzvgLHDYDQ9FXQHyG+VC17Jat50bNtSgoKhHZ8HIsw==;5:8N08Ep7+hH+GIiJnqqUSde+xB6MowAYq+pWs0tQFugxUF+U6Si8mqVuy0CjgQk6NF8zjHzwOPuikA5TmGeJkj9TFKoR4plhblsJ78trNVolyZB4jWXQSxDnOj3M1Xpckmo7ZkrZE+hoAkyaysaw0pv7d8zIYfWaXe9Kja+AltmA=;7:W7WxjJciUEiZGD+tg/nWU1YhsyOnpMbGv8A/I8+ratGFzK8/J96g7Hd5/HpG1AEsvHghtGJqMz1IsBAM4KZQ9O9Z2Os7OmJX4ZiwzjUAM29O4XNMQR0YzPLYNhr2sWpAjI2zmg2vDXMdXf94SQ63pazJSTOlLYe6BbTBRpWTSibLOEEgYUxnpKnMj/wUqAN88eExGSmdRdIWguPpJT6Kf+GN3jty638J23CHZdSg9/VwofY12BsF3X3ttO6nDBXG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3c1c2a3b-734c-4057-f101-08d612d67da1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2803;
x-ms-traffictypediagnostic: AM5PR0402MB2803:
x-microsoft-antispam-prvs: <AM5PR0402MB2803865DCDDA88015CB3093DF1020@AM5PR0402MB2803.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:AM5PR0402MB2803;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2803;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(136003)(366004)(396003)(376002)(346002)(39860400002)(13464003)(199004)(189003)(33656002)(53936002)(99286004)(478600001)(7696005)(76176011)(9686003)(68736007)(53546011)(229853002)(186003)(6436002)(97736004)(55016002)(26005)(102836004)(25786009)(74316002)(6506007)(6246003)(7736002)(106356001)(305945005)(14454004)(8676002)(105586002)(4326008)(316002)(54906003)(81156014)(81166006)(86362001)(3846002)(8936002)(486006)(5660300001)(2900100001)(6116002)(256004)(11346002)(5250100002)(66066001)(15650500001)(446003)(476003)(6916009)(14444005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2803;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: if6xWkK6XxhvKto8jDf3U00LlGT6mc14Wb5rUOTBxNdeukPRzO06D8gDy8z/r2ngX5xrxlGdEad72G2JrWQCQIQhfWsiZQzPvnQawGsww33bKPHwQVfJHbYDXkg+utKJplYqPQU0vhFvgPQsSahmGCEbIZfJwJCBgaw5wsvpEindwz+C353fIXNjxJeH1g9+IoB9UkQoMLFXIQVcJopsbgA+TfZ+ZILceh2WovWdWnMarYPMdKKy/GUwTpvhmtXWyUtGKmq+2otBryVzNC51vFPtRC/oTT+79FSmAzHRPJU591GDmlorR8RBK2W8vO6T9sKMq2L4u/6S72EHq/nvFiZdrn+1QW4bjOOSgugBQYQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1c2a3b-734c-4057-f101-08d612d67da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 02:22:55.9101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, September 04, 2018 09:25
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Leo Li <leoyang.li@nxp.com>; Mark Rutland <mark.rutland@arm.com>;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/3] Documentation: dt: binding: fsl: update property
> description for RCPM
>=20
> On Fri, Aug 31, 2018 at 11:52:18AM +0800, Ran Wang wrote:
> > Add property 'big-endian' and supportted IP's configuration info.
> > Remove property 'fsl,#rcpm-wakeup-cell'.
>=20
> "dt-bindings: soc: ..." for the subject
>=20
> It is obvious reading the diff you are removing fsl,#rcpm-wakeup-cell.
> What is not obvious is why? The commit msg should answer that.

Sure, I will add this in next version patch.

> You also are mixing several things in this patch like adding ls1012 which=
 you
> don't mention. Please split.

Got it, will split them and add more information in next version.
=20
Ran
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |   42 ++++++------=
-----
> --
> >  1 files changed, 13 insertions(+), 29 deletions(-)

