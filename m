Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EA4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9402175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZQltQxey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9402175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbeHMVtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:49:14 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:53184
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730602AbeHMVtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzEC9tcSVeFLZ8DYAoegq4jyTXlveA5+eCZWSDUHs7Y=;
 b=ZQltQxeyXMAjOEyRXazSyey57p20Wm4Vm9R7oIgiEPQds+kPpVQoeibDHe0X/O+A6I9Si2uIQ+5HPeSndiQW6lIjfx+6QJTbO5mgO2uD7TSDjCReFPiQaWp7g0ZFYcPVd+AxqoEOacfvpHw/JDDB4sO5dIw76/dAGnj4BfbOiCo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0279.namprd21.prod.outlook.com (10.173.193.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.1; Mon, 13 Aug 2018 19:05:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1080.002; Mon, 13 Aug 2018
 19:05:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH 1/3] tools/lib/lockdep: update Sasha Levin email to MSFT
Thread-Topic: [PATCH 1/3] tools/lib/lockdep: update Sasha Levin email to MSFT
Thread-Index: AQHUMzievv5e0uvilUWzIuicn+uY9Q==
Date:   Mon, 13 Aug 2018 19:05:37 +0000
Message-ID: <20180813190527.16853-2-alexander.levin@microsoft.com>
References: <20180813190527.16853-1-alexander.levin@microsoft.com>
In-Reply-To: <20180813190527.16853-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0279;6:FKZd6PggO/XzhxW6/HEokGl8B5dfLkZDA/M9KN1GDtwjx5Otftgi1UtcVR+8Cri4J5G3qa9A+2oZJLoNsQmieJInVUqS/3Wtg4iZXTsQB2sYpcMH16ml4YCRhFrBoESU5TfgWXAPa2qGmyqCcz4mb/+/X+8beFSnyJn6E3IyK5eyK4OkXNjGST+WvBmWYiFqrQUZls5Kq24YG4aC/2pzb3KmwuqUtuOViqZPNSZFGcbl5hd5XggOddiAU0j76m/ObM19RkAK+pqPLFOMt3uvQlye3McKbLcCg1SBZEYJ3Gjil/wcvVsxNzTa9/B8L+5wcwfpDptqzcsi3wtr/6XzZ1oLhHQxsq3s+xYvtOQN04PQU5/9ncWzn2IPvlPiEQIDeK/1eAq5bY0Zu4eWrFoP5iSDvtCrx3YpRp6JtdakAHM2qfjBQTJ/h8OaPxCqBxCwOYr8UJYkg+ri3vgR/AE6aA==;5:XrsXKJr6QVJuiE+RhRmtSyXLBVbtqTm9+JG4UxBz0yIZlybGWFZnDVwsfC6kjdqqV4ri8OsLKEMZ9kkJ+KYbRcYO7L5GMRhA/Zcm6VOQR9K+e/4d5wEf3Z+RoaFhjMaPCqAhE2pzQuUJ6kmKrFHZnnzBNmsWYDSgpNVwDIJnUtQ=;7:2IoOLprc7dGKiqjyOTY2qaYJFGyVaJBVzClUoCSK+HGBbQwvyg+4oNUhKbHBrPj4q4ZMoQ1qu8Wxy7D2byrDz1kbehoOtD+tOwM4ayndLAritrLdVLteF0CTMrDfoI9KFcZf/OUCCoh+SJkkgZ07lNRHiPqrRhuExi/c7EMwoKbYui4FKwz7ZNHWxRTp1iwTMSpv7OTsTIITVZ2Vj42gXdiIDqIftmjTTlpvFtttj+D+MWppCQrRrTGuQJz+Xqjp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 51aa6f87-7625-4180-f389-08d6014fc174
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:CY4PR21MB0279;
x-ms-traffictypediagnostic: CY4PR21MB0279:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0279DE90304416C16704B30FFB390@CY4PR21MB0279.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(154440410675630);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR21MB0279;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0279;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(102836004)(66066001)(106356001)(26005)(478600001)(107886003)(81166006)(81156014)(10090500001)(8676002)(186003)(99286004)(10290500003)(86612001)(14454004)(11346002)(86362001)(2616005)(476003)(72206003)(446003)(105586002)(486006)(6506007)(76176011)(4326008)(6486002)(110136005)(54906003)(6436002)(22452003)(97736004)(5250100002)(14444005)(256004)(316002)(6512007)(2501003)(25786009)(5660300001)(53936002)(7736002)(305945005)(2906002)(36756003)(8936002)(68736007)(2900100001)(1076002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0279;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ymfzav3Si6rUeh1xTuW3GqvXqWHjyPzOM1bJB/NkGPYjdk+znvLO7+Gnb72IGDZRaAqv8wvcEqSVq4sgMThwDAhHLWPNx/r23svPUYFyCItbADRuZ3g6DUnk0N7WLx3ap10oiqVKpaf8jdEeJ3xxj9NJ62q5vHpQCRDPgNgNTI8PrXavcdDqcYu+WJLzCYjzhG8Fke6t75fPi4AlklQbP430HzUcZ1IZuBjxCH8tWJiP05ZLKqs7hJARWrTTBqeWpw2Df5yEhJ0GgcjSzAfDtO6YMeW2+NDyKlWIaccJ+Z73VERr1lsRKK4MqzrOPKpz4r5N6tURZ/jEZZ6O9mhfEwV6BMv6MksIh6+IGMoEnq8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aa6f87-7625-4180-f389-08d6014fc174
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 19:05:37.8614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac829cf4..2e02bae7b7e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8143,7 +8143,7 @@ F:	include/linux/libata.h
 F:	Documentation/devicetree/bindings/ata/
=20
 LIBLOCKDEP
-M:	Sasha Levin <alexander.levin@verizon.com>
+M:	Sasha Levin <alexander.levin@microsoft.com>
 S:	Maintained
 F:	tools/lib/lockdep/
=20
--=20
2.17.1
