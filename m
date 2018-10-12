Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4C8C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120772098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="f3gVHzuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120772098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeJLWTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:19:31 -0400
Received: from mail-eopbgr20109.outbound.protection.outlook.com ([40.107.2.109]:53180
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728697AbeJLWT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVwIVZ8k8KVjqSst6AxDSDQp8y8iCOBozQEo3iVLVO4=;
 b=f3gVHzuKTxb/vUv99hXJFQpczNKDt5XUGwxmAznQIX2AheYAZw1Xk4kwFz5jPKjZjsLpkukKTBrJ1/y74B+3EhYR+tCaoHpjB1d4of3vvSmCCSao6iB5iIvOoCrk0KIhSlRzGI+d2LC+hQMwFSqwzO1Pf753JG7bbFn/J5Xkb4g=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2320.eurprd02.prod.outlook.com (10.168.63.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Fri, 12 Oct 2018 14:46:40 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905%7]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 14:46:40 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mux: adgs1408: use the correct MODULE_LICENSE
Thread-Topic: [PATCH 1/2] mux: adgs1408: use the correct MODULE_LICENSE
Thread-Index: AQHUYjpiBdkFb7CYCkmP2ICXfSi2Ww==
Date:   Fri, 12 Oct 2018 14:46:40 +0000
Message-ID: <20181012144625.9345-2-peda@axentia.se>
References: <20181012144625.9345-1-peda@axentia.se>
In-Reply-To: <20181012144625.9345-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0216.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::16) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2320;6:rkK+XrlYPNlirJmNL+t6oS1vRuCS0W62oFawBbHgzSACEY9EbDM3U0qUEx5YFqiiUG3l3F5q68pobsqAwQxDISKGsreoyWfgZGhZZ3v8ZWNUTz2hDy5SacTEK2N42T3iQV+bxvhdT2ZM1VW0dtKjPdo4C3WeYXOHOgbbIaF36XQaORrMrAKLdEo/T302cTxWWW0UGLy7r9h2dJgvJVPwLXLEGIxXpGt1U5psq63z4zRo1LCAafI0Ww1HPa6ploJCqFTge4A1lrw6V7hK0TYiyMsQH+MpPrKIvEH2YORu6+RpRJzkPuUMPFphJ+gupzIxEulwnDcKIg61shjeiaYF9azCBNYmRvdnWDX68gmgNJvVPbR/sNOvibTAoeC+G+iPTfXeinTzNY4Czf8qF6Y7RsIxA/AkD08x2T/AaV5GDssZR4jm9z3glg+Q0bkmi+B9lhekE+NMKsKzPiWqFCAu/Q==;5:7wCB68Lb0ynglLdK2Ir2PWCJ77pa52b0f+rHzolf1R1t17m9xboHBHQUuw3VmyLcbOQNTE4gKebHaduaCgaJdEP6i62DteRckOUHARaPcKw4huP/LRMCfiwxb18RoJPFRf7gEOnzN/RlBIk7NTHO5v8sXXXpbElkEgO5zEzOdf8=;7:q94cJGay5TsJKs49NC1KQNiLghQOos/AVQd7iTeLNhcZgzNeTZ5OxbEIka9HNYFoPZLuHXHuouLCtWoAbVJZJ4PB2uywivVa2TBcBqcSDqg/mv3v0NaqjYSr22MQZ/DH43y35Y/huY5sxbFQDkiD4HEepYBQi29O/elnDzzfRkmFhD22Vvc06m72ZdYCYVM8cbOqKEVpRRwqCPMpT01A73LKPFpuY8fIfFAH7utBWMggZY5zgmnRoNU8BQgAd/t1
x-ms-office365-filtering-correlation-id: 8caa346e-ee99-49ba-384e-08d6305184ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2320;
x-ms-traffictypediagnostic: VI1PR0201MB2320:
x-microsoft-antispam-prvs: <VI1PR0201MB2320FF267D02548C6586609CBCE20@VI1PR0201MB2320.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(232431446821674);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991067);SRVR:VI1PR0201MB2320;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2320;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39830400003)(376002)(396003)(199004)(189003)(316002)(99286004)(4326008)(8936002)(97736004)(53936002)(68736007)(5660300001)(81156014)(71190400001)(71200400001)(81166006)(26005)(5250100002)(54906003)(305945005)(14454004)(76176011)(52116002)(2900100001)(66066001)(256004)(386003)(6506007)(8676002)(7736002)(102836004)(508600001)(50226002)(6436002)(14444005)(186003)(6512007)(6486002)(86362001)(11346002)(446003)(6116002)(3846002)(6916009)(2616005)(476003)(105586002)(106356001)(486006)(1076002)(36756003)(2906002)(74482002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2320;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vR42Da9zfC9Bz4QSW0T/ehYAQ1QJMLBUEleeCVar6l+0oflMCfrqARFC/9QnF68LOdnsVGA7DabhhGrSEN2S2rkpfgGrb1A2+GMDnR5WOKBt7EpP2IkqhwxqJuPNA2uuEsoRSYerkLR//13MUPyc0588EMyFKCN0LEgNARAKxuL0EXQnywcuc4h/bFGjMd7MHLF9p88debuan/TT5rZYpkqR3Wcbi7opwJml5LxshBKpiKHCcjKZzcBklzxHw+19u8HxCoJ8onzy3NM8aU7NQlNqNhVQv9DKQG3x1VYnmP7li68SdoFOWfYK4JWNzMkYcURNDPzygctCUre4bcOmagT8z9BTJUsaDsqwBheZeVQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caa346e-ee99-49ba-384e-08d6305184ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 14:46:40.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file is GPL v2 or later.

Acked-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/adgs1408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
index 0f7cf54e3234..89096f10f4c4 100644
--- a/drivers/mux/adgs1408.c
+++ b/drivers/mux/adgs1408.c
@@ -128,4 +128,4 @@ module_spi_driver(adgs1408_driver);
=20
 MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
--=20
2.11.0

