Return-Path: <yehs1@lenovo.com>
X-Google-Smtp-Source: AB8JxZqBne5IlTUML0LYZJYspuCR67GSDouiywYVzf6J4OyeV+rNe0vBlVWc54CYvWqYQae4edMI
ARC-Seal: i=1; a=rsa-sha256; t=1526984581; cv=none;
        d=google.com; s=arc-20160816;
        b=XgbMiNhskCs0pK/FDSeit7RkbsEIZY7XBDoRc0zo2FEhDK5p3PcOr2DM0VCXp3+C9B
         BQGOSbG+Lhv1Vq7QCYBXjzgQiMLlvdTf3+/IC2pZHtPRAn06KIOq6XtflfOeUXAfpLPf
         v4UYioeWutzs1dD9ATrEufyJi2nktjyEHauv3qcgKASGZXL9YhLdjrJN6Bq5jbTdMCcf
         Fc9YPa1/bjCyEJPaOjTzLJrZNjZJKQc6XZTXVYvYqxqilYcyxQ56xBmNbp6hljkPU3hR
         MZiUyyViPONf7qjBS9ghp6qg39NBiGvL7l8rWBDhS5K/44vInvcrS+ld7mh6+K6PWyva
         v2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=c+XYlwzPYXho6RKw92wv5h0zKxlJDyPTpWUfe0yqYAQ=;
        b=VIIbUYETNiAJVJ76OQ+X3GvLy7c2/+PkkgHWkYeUsKKK6hQ+shlYTXksNs2eVdQx7g
         rYhGySpUnLhH1quhd1ABmUubRaB46Ygvg+HaPsZlYQ6WNTad1ng2vClQw4+NubYTw473
         9A3QsM9QwoifyuUV0qoqTU0uUtO/dEdJkiX0RK0fFP5tKZG4Bsd+qLcMkw3znrMZkPwY
         d8UPPVigpribKmLvNF2halRSVK/tSXvO9vEI329MRDXQthdncgteBsiWtKR5qAXhM3uL
         0dtMBsTvQWoo1y/iuO5+ZaahDlSJxNZHj092hOwvBAlEVZMZtu98qXw/k0ZzeUQoheX3
         Zt3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=g6JMn/lT;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.12 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=g6JMn/lT;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.12 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTb0wbdRjH/d2f3rlwy1HoeGyAZE2WuGJhNS6
  5REUS3twb/75w2dic13nrXWwL9joDuhdjdegAO8IMYwVCB+PPSLGDsVlF1wUZbEKcVhxoIn+E
  za0OXEaWLjSKdz039V59nuf7/T6/5y6/o3HjMcpMi5U+0esRXBbDBkK6tYDZPvgDL9s225vLt
  UbCBq7josSdqL5Gcf7OiIGbaOjAuFDsWa6+9TDi4ou9FPfDF60Gbja8TnLRrosYNxco4VqqA4
  hLPVD7yaHjGJdKHiVKWP7z4C8Uf67Xyg/ea6T4K80pgo+1hSn++EwP4r++O0XwkaEfCX4yNKr
  aJt7nz68V80eSJn51MP8VZhcpexzllW+S0rcD1WTFDF65OvMndgjV4LXocdrI/obg0zvWWrRB
  5TEEtdUthFYQbC8O0wP9uK4EMAj8lKD0Yg6Bf3gynTewW+Hqnetpzlb5554P0wmcTRggenPeo
  AlZ7AvQ5O+hdFMJzNdPYToXQnIlqnpo9bwtsNy8V0OG3Q0tNXs0B2LzoOnXubQbZ3OgrSlIag
  wsC6e/vIbrbILbi3+RWhSxr8HK0Bt6ezPcXxgndM6DeHsd0jYDtoGE2MAlpAt2GD8Tw3VhmYS
  j7X5SLy4gCHVNY9pUYK0wFsnUA2/DWPeJf6Za4aPRIKZzPvR9vEDo2UEczq9HST2bC8nLBfq3
  lqC28QzS2kbWAf0puQHZgv95NZ2fgtDwPYPOBdB96ndcY4bNhKsnl4gQIvrQk4rofVf02uzbC
  h1e2Sn53ILsstntTxe6RUURnKJLcCiF+8rdg0i9nI+pTxR91106gp6gMYuJef0GXmbc6Ch/q0
  oSFGmv94BLVEZQLk1bgOlaUbVMr+gUK/fLLvWGP5SBzrBkM6c0mVEqBLciO3XpG2Sjw0ON9bi
  R8JR7RHMOM6mZWM0kHfA8GvHwP4mjPHMWg9SljBkVotct+/6vJ1AOjSxZTJ02JUP2+B6dlFCX
  wNQlvu9JL+ET/pXMh1B7ylxkKbi0hwln56/333oZHewbfm9zaf5nR5beCbR9Ypp4Tu7cstjWf
  O7kzqq66w9enJ/ZdPr5YG7OsbLOK6P7LP7lm6+OO+8XLa3dODtLx7bv2kk2flU18tImE9Ucb9
  m/I7F2+PZYccHlVFeNo7To7qpwcCq1XZkufiYeYXZs7NgqWAhFEuxW3KsIfwMt4NfpIgQAAA=
  =
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-11.tower-168.messagelabs.com!1526984576!70246532!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@suse.com"
	<mhocko@suse.com>, "willy@infradead.org" <willy@infradead.org>, "vbabka@suse.cz" <vbabka@suse.cz>, "mgorman@techsingularity.net"
	<mgorman@techsingularity.net>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "alexander.levin@verizon.com"
	<alexander.levin@verizon.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "colyli@suse.de" <colyli@suse.de>, "NingTing
 Cheng" <chengnt@lenovo.com>, Ocean HY1 He <hehy1@lenovo.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Huaisheng Ye
	<yehs2007@gmail.com>
Subject: Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Thread-Topic: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Thread-Index: AdPxtsf+Eq9bjrIzTSaEGgYFvgy08w==
Date: Tue, 22 May 2018 10:22:42 +0000
Message-ID: <HK2PR03MB168444ADEEFF5D6397FB94D992940@HK2PR03MB1684.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.65.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1604;7:cISCf07PnjtcZ7rY6tP2ErQA+oT9u0QNIP89QD15dZ79xd+S51h1RrfSkAosI7/Fm6iSsq8VtJnD77ggqYN1O08v1EO8h5c47c4H16LCizvlmQAj2dWa4En2Jw2a9phRjgQAVGoX3GjwaxV0fb9DJ+5Bcc5bDQYq+JlHJ2RmTeCBQaHzHqaqnMGz2n2MHUW8JyTumLKt61qznJaVaGgQKvEzigM/YwU8OVtXVO9O7aUvjq+x1vFyJ0dxM5Bbrolm;20:+1yIx9NIeixl6MSpjit7SUIAR6vV1jeFulNCOZzECyL2YA31R1MqcqsnmkO6LjwYu8rFn7GTW++78RZWSP05NmAfAPudE5Ds28M1PhNQp2PydFziFoddm927kQXgOK2lus7z4YN3FkU3JTbTUaTH+0dtCCQTEjnU6/zDHEV6Abxy3yt0xr1tAGeUwJ7sGL04PxAWTES2wrs1CoMdaLFsOLf8YFyxbs6l6lVTi1oF8RmbBe92dspDj/oaTLR12PTks5kZkcoS0UoQ5N/KiIgxIrrKn8GyVPTb3uOfwjpWz9UEqSA5QgEw9C7owB8qkMNU08dBqMPnxGjo8FCGwuOMHw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(396003)(39850400004)(376002)(39380400002)(366004)(189003)(199004)(66066001)(316002)(3846002)(5660300001)(2906002)(7416002)(5250100002)(97736004)(6916009)(102836004)(26005)(186003)(7696005)(6506007)(2900100001)(86362001)(3280700002)(3660700001)(486006)(99286004)(476003)(74316002)(305945005)(229853002)(68736007)(105586002)(53936002)(9686003)(478600001)(6436002)(7736002)(55016002)(106356001)(6116002)(14454004)(54906003)(8936002)(4326008)(6246003)(33656002)(81166006)(81156014)(8676002)(39060400002)(25786009)(26583001)(9126004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1604;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1604;
x-ms-traffictypediagnostic: HK2PR03MB1604:
x-microsoft-antispam-prvs: <HK2PR03MB1604462D17A677F023D5C29492940@HK2PR03MB1604.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB1604;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1604;
x-forefront-prvs: 0680FADD48
x-microsoft-antispam-message-info: WEQxw+Y8zct5C69gM0QrJfBS406Fb8Wj9YJWDVYhYJsZBKRbOz/zPOW7Cl+m9MOk+w+PU7BT/qB+F1V/T3O/gag8RSX4hcndhLiFQ4GdFsebENijS1d7Vjz4Oz5vJeTXcyKz+oSPP6IJaMbE9EPAsKn40iVgAC9KWwY/Po0BdBVXIXq2yyZCkB1/mI8FYVML
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 978460a8-a80e-452b-aef9-08d5bfcdf3f8
X-MS-Exchange-CrossTenant-Network-Message-Id: 978460a8-a80e-452b-aef9-08d5bfcdf3f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 10:22:42.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1604
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087516393165793?=
X-GMAIL-MSGID: =?utf-8?q?1601159384938018225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: owner-linux-mm@kvack.org On Behalf Of Christoph Hellwig
> This seems to be missing patch 1 and generally be in somewhat odd format.
> Can you try to resend it with git-send-email and against current Linus'
> tree?
>=20
Sure, I will rebase them to current mainline ASAP.

> Also I'd suggest you do cleanups like adding and using __GFP_ZONE_MASK
> at the beginning of the series before doing any real changes.

Ok, thanks for your suggestion.

Sincerely,
Huaisheng Ye
