Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3506551-1524154284-2-8028716581272122054
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RO'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524154283; b=FJvXX+MN2FualJRqFk/3rEFaMYmFr/+8D4esIelLAxLgAFqxR2
    ZbffakLhwhRvpMmbrOCtdxEZeTgvN04CFaccvC4sEbZWb1ekYQ/VlTsnba3BLeqZ
    74tjL45UG73e9SknqeVTaCsnizxdFVkl/o+umXgbjs291WBNvL4EpNkWkwlm/rrG
    wIWaGm9fqG1To0rKM4Qg88vyILRGO9Mg4E1Aikg80B4DMkvXxwFMpGulybN/LWNp
    8TpsHKW47WOsjUYup2zFUoeKcrwRE7n1qIU8etuEd9+HTySXpAKwjblx+84Apcs0
    eJ99tdYTW//5ZG2D7V9GnudI8Mys7QGMv52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524154283;
    bh=Bhe8xaSZ1Xw7qEBlISndYfAKiG5woJhJQfyooQaqF+E=; b=SJV13tXREvKz
    5WEOWv7kDuloYoSmQ5GYp1O4fHMKt6I/2lnl8OltIpAXCS3Z5EUGyJwzQ9BA8Xyy
    nPjmbD7opNHfK88AmLjLyA7oVbwBWYYkb0qDevODP12GEIbQECPpIMjsqVUOaEP8
    xwJ6vMYl9NaaX/d+mzRotUME6pYIxFlb8paGvjwJjO3Ghh4TokHXpXyG4VIcvb3u
    t572otre0leBnyf4U+o77ZUkgNh3FhWrxUdvXhnP/uw+unDQ8JqgW2B5hlsqLSxA
    fqOXW0ish9HhRN9BzavOPQd9m4HSv8kw9+s9xRdIXGTQfj85LR7qn/8m4+aPSaV4
    X30bgWeqiw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=R6hqTTZo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=R6hqTTZo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDoWp1S4kcGHao3bFyLOc1OC0qgz2px/+I6sRyTmNFkwwZ1XB4GrylHTiaxDtVD/yLUtEAkRBWTonRHgHeIS9+Ud25TKOSKpNY2aR3xWuwAqvbPm2oJD
    tjmp1Y4SNA+i10qhzKAXVAgxWhmV6ynKpESGk7X6HuBGIBWo57UsJuPugYCGYbz0lvfU6bFZ0YOuQFLtCNESsYw3tyeHqS3mBcCwYZ6n62Lzku9XI4CAHGOI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=iVpdfP-iKAwA:10 a=dk0mmkUsIpsA:10 a=AmCQcqNUIw4A:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=dw2S5ISiLjYA:10 a=ag1SF4gXAAAA:8 a=8AirrxEcAAAA:8
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=KKAkSRfTAAAA:8
    a=dFtb7w-YQg-5Myv_mnIA:9 a=PJMN4DnkVjg248Wa:21 a=pPx0JOz0WTTCxGYu:21
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=ST-jHhOKWsTCqRlWije3:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753675AbeDSQLV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 12:11:21 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:7296
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753577AbeDSQLT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 19 Apr 2018 12:11:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
Message-ID: <1524154267.17017.15.camel@nxp.com>
Subject: Re: [PATCH 4.9 181/310] net: phy: micrel: Restore led_mode and
 clk_sel on resume
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc: open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 19 Apr 2018 19:11:07 +0300
In-Reply-To: <CA+G9fYtR_3AXKvhrkE3WEZhVOX6XwJ1r38PLav1XKkz4L4eQZQ@mail.gmail.com>
References: <20180411183622.305902791@linuxfoundation.org>
         <20180411183630.390575424@linuxfoundation.org>
         <CA+G9fYtR_3AXKvhrkE3WEZhVOX6XwJ1r38PLav1XKkz4L4eQZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM6P193CA0016.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::29) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:2Rg+DYk4o+jRyRmOLTPS9q/hucnvJwTjReSdPwHUePCCCRYxQCdrbOmjnTHuCDD+cIxca3pCy+kM70pdj5sJ0ZodSSNOwLh4tRqhNlfNk/wIVZK5ePULOrU9dGYTtxMR3A4iUSza3dgPk3H01qCoXobjNyu7+JcBtXGN9SXPDETKvges8bE2dOPSc+SVVR8iXM/5LsJHitRnZ1i1fkjD9pc2ZONgTJWMHqbWIisYogsibUv7HFPk7CtL3rjzPG7T;25:JlYZbeumg7W4IESxxAZ8Y2PoZ4IGgiRHCNRCTCrusJ6w5RxVU+LOiRAJaJNKOGubKDKoLRAd8PspgmApH0G9S/6hp/Bbw+sWxA336cDIVk/6+IoHy6KpR14f2bAmG1PuohqfPcPgYUeAML7U6A2i160JI9qjeZzYN7Arg5/z3x8XhcKNkXX+Phd3zTGf9b7uStbSO9BRK3S+Wl1pKiWcLs+34cSq+R1HV3GU6OV3/iHK9pW0o5w0MFv5KcU5MvZkhP0NQcOsMC/MZ6AN8RW7UAJzIbxH+KWjOvgvyXl8dbf6iIZw0WH3BqMrDfS68sr0q39ivxezNdHBLBLePfgtCw==;31:bHfYT/VdTqQcS0zXYWyowyiXIpHwbfe45YXjOrZGfMxKK52egBjCQCu4qOdKw0EGXuoZf/5k6zgPmXxN15D4iq1hMnFy1NhMfLX9SE+RS72UFcWiswMkhmoiieu+V1xvoDPwowBp0msDKkdthnNYK8JtEd19Ze8eJdl/t3QzU70pIk6q0JKoQsqAMIHA9wfKrJUN4mCMjDPGYqr9RH4C0kYGpQ049AmQ9FVgrULpNR4=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:0S3Isf4uXSKKkylnd90Diwj3+YWDovQDtsL5U2eO4bniV+okfdk8iAdtkiDX6Qze3HQORTf4CKX5ar2lnjXe3QPQqOwee862oo4VAtJZIY/OBfFnMG0xna4m+ZsxqWBgMvG/JVwC4XVgvbh5iToFNmV3fjK9oROl6m3xatrRd/e7PGmUMu2njVh1qTtjM+2dJSV2oN7u+q92LCYq3v1k3BkzhNQ3xwJz3KpZmyizt4R6O12STF8fojsTTmkJ+IHSo2XU7q0dqjdE6EQYbx3l+wigdcMMT7xHu9lP3AjUq/XcVZpYGNY8q26GkTo1amWDjZrIIXU/+rSNizMEXaKXBO3xh+mzaGVeD101dpC9oqOElaF9PSfAJI5+Cx5n+fIo2oC1gJoh/7gSxU+GM9xQyLPcCCBkXg6bqzp8NEymcCVWQdUfHvtL99bqN80VtwjU08OIBZUgS9bxbDJs9EDhhANyQIb9yddi8JO+8S6KB/8J7CF9XgE7FzL5XmoJy9Ey;4:xgXoDTClEDPrgTC/+nVlUJrX8Tb1FjX/TUF0lXNfTH+ikRuk83jcIMZUEzDE/aS3mlRBVcXsBISMZ5GJSaaEfQPY9lA9EJ8Uup/wIKfmhgLe/dhryBD6E/kdCNy3cK81e5TqQaCabhUGugibAZc32yOJXzwOoAHoqeTSNSBnWjkQuUJjigf5t5LUkzoMFbgKh5HVFUqEPInlVxlI+eslLKFWRNFwhOSUCEw6ULp2lureKfcivG2VrovZUMdt5Ti+UBUM1S31LwuykUVu1Ly7nxEFU7MR50nSpdytSTLSISQIM084CasMeArJ9AkLCW6/pk3oW3OnSDzk9YHSfPd89T0cEBFdSSp254nN+Lham/8d2Vvpp0FxKJ8fPzZZ37JRPpVhuRbmtwYdzjp9xJBEOJko/i/WZDZJUyze+w3ItI0=
X-Microsoft-Antispam-PRVS: <AM0PR04MB429029B79DE4A44FFC9D92C4EEB50@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231232)(944501383)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(377424004)(305945005)(3846002)(5820100001)(2616005)(476003)(956004)(2906002)(11346002)(6486002)(50466002)(103116003)(575784001)(6246003)(44832011)(110136005)(229853002)(86362001)(316002)(26005)(45080400002)(6666003)(66066001)(53936002)(52116002)(39060400002)(5660300001)(6496006)(966005)(23676004)(36756003)(76176011)(54906003)(47776003)(6116002)(478600001)(4326008)(59450400001)(386003)(16526019)(53546011)(2870700001)(186003)(81166006)(25786009)(7736002)(8936002)(446003)(6306002)(8676002)(8666007)(50226002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:fsr-ub1664-115;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0MjkwOzIzOkdOelJLU2FLZ2xBQkJGMG0xSTVFWEZPRUow?=
 =?utf-8?B?QmxrMFJLZ0NOWEwyWHg1N1ZzeTVncXljZGtVeVBEa1hzWW4xNHJWcHp1K0lp?=
 =?utf-8?B?NWgyVUhveDNjdTZES3E2WUFyVk5rdDdJaFdueHdMeDBoRlJpMmpHUkVxdDBY?=
 =?utf-8?B?cllxQ2NOWXRnZ1NwSG1Nbkl1WWxGaGd5L1I3QlpOdy9JSXhySGc2UmxTNTZ6?=
 =?utf-8?B?TGVIUHBuaTZZanlPUmYwbkt3ZlBpUXNkUjNWbFgvcHFBVTdacjlZL3dRdFVz?=
 =?utf-8?B?WEpXb3o1aVRUaHM4TzlsVzlaQnFyL1ZXRzJsY1J6Z21BanBzdU5xckZ3U0Jp?=
 =?utf-8?B?S25GdWRwMGZaMzdqWG10UlBCN0R5dE9LbUpodnBQS0lqZzlPSllIdmM3cWJu?=
 =?utf-8?B?NVpVOXBOT0hjT0FqeHFycjRDSGhOMnFoMDlOUlVpaTBlYWpMNHZaT21ibG5m?=
 =?utf-8?B?aWxWRlZ6RURtL2Z0KzlEZGtVWkk5TWgxM1RTbWZWTE1qMzhoSjNQWVhjaXpV?=
 =?utf-8?B?b3FHdzlSc3F4RjJiR3BnRnh3dHlNUHNEZW0yVG9ZOER2TDE3UFZqdU10c2Y1?=
 =?utf-8?B?dCtodFFJR21uZGhVRk84U3F0MTJuaCt3WFlxd2wxd2JENjEvQVg2WnA3YTJL?=
 =?utf-8?B?TW40YndXUVpmd0dDQitxUUVQUlE0VEJ6aWo1UDBLQ0RGNmVHSzRucDJUdGND?=
 =?utf-8?B?UWh3dU9TcDNoT0dQUmJNRVJzdnZSSmVPa09VanpSQk5oNFNwZGhOWnFjWjY3?=
 =?utf-8?B?OFlwd0dRUnFlRW00SWhaN202ZW1oTS84bVBKV0tkYzI5WG1uTGJSc2NSYStt?=
 =?utf-8?B?bUFabWw5SW1QSTRPYkxxNElOVVlXcWpsQ2ZmMHpLeHZIZHNDYjdRalpLc3Rr?=
 =?utf-8?B?Nmp3ZHB4RkFoVzJ4akFiSFlWRUk5WG0wSDhvdTBSR3BpSmtSWEREOFVtNmJo?=
 =?utf-8?B?WWhuNXpScUQraU1ZaVI2TzBSdWszSFhqeGdrMXlKdEFFNDVTbVRIb0JjdmNp?=
 =?utf-8?B?VFlwa0tzcitYWjlDSDNiclFtNTBJaXhSWVFZWDlpYjE4QjVmWWgxM2lDNk9v?=
 =?utf-8?B?N1lKOVEzQkkzdFQvZEdxdjlFbFI4Tkk2ZkhGS1dweHllV0o5RkVwNWRCcmNy?=
 =?utf-8?B?cHZUMXdnNjh2eHU0UTJHaVRSdXd6ZEJXbm1PcFhWRHFDczl5bTlNdi9Pc094?=
 =?utf-8?B?ZDhDZVVFK0VSS25DT1B0QnlRcmI0cGtrUnZmdk85dld0WXcrREwyUkxJQkkv?=
 =?utf-8?B?aDA5blNFemRVVmxEeDhtUk1hcXo2M2Ryb1YwR0YyeE5wc29GRGlNeDlIblVm?=
 =?utf-8?B?NUt1NytnR3B4UVVJSllGNVBEYldRdWNESkt4NlB5cGpwL3hnYnNqZEhITHhs?=
 =?utf-8?B?TGp4cll6NFpjdS9YeWViOERRdkxGZDNRcFNRZzZQRlRTQStiWDU2NDVNWVRl?=
 =?utf-8?B?WGlnVEZ5dERTald6YlhMcmtTbmtoNEhOUGFVeVpZS3dJek9LNWQzcUNxSzZB?=
 =?utf-8?B?cUFQTVRRVTVDaXZhNEZ4dUtaT29qTzFPQmNNL3IxdkIvd0VUSlFVU0Y2NVJK?=
 =?utf-8?B?MUQ3MFF3VjhENVNFS3FVcnJTVDNxZUVxRGliZzhOcU0zZFVISXhGUUVQSnNY?=
 =?utf-8?B?dnoraFlWUnFDOUg4dzhBZnBEam4vME5zd2VPY2pwZ2xjaXBsYlFnaGQ3WDJs?=
 =?utf-8?B?eEJ4Zm1VL2JTNHY1ZGpJMFZhdFJQakdJZ0J1RzlJY1ZHeCtrMmpUVkFhNTR3?=
 =?utf-8?B?Q2dlQjdqWVpKU082K0Z4R0tVL2VUQkFhdk8wYlFSS2lxR3BJRHVYTnlBQ2hO?=
 =?utf-8?B?M1BnNU02cVlzdWZLN04wM1BQVU9DbkgrQTdub2tqMkQ2SkE9PQ==?=
X-Microsoft-Antispam-Message-Info: GZ+ogSrQqx9NBw7othaDN/bAYbdiW2KTPvTnRMaaZk6+z+VVSeQlilVOpfOugMOsw2n27VM5Nwb77XCbT5YGzdEWgitVTBRJgKQhIryeJzGkcUZ1V7pB0Mz7Y/glyo0GX4IARr5PQrBR3n7f2Ou/dmfrR5bHsVhfKWY3fUbzIs5ZkeOLN5PFv2FrnCNGvV+C
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:av+w58VmmQDWWbMsW9jk7ryZH1owyqHBsNHCQGJqUioE8edxilmA9wWRgOnU9edbevifl5wXwALwnsRRCrwhxO5FmA/qHKICMvP6hiiI+EM2K9oRJnssAMD6TtsFJyNpbjGKBxy7+urkwLupqQyiWnqC1M8dhWaH7h1zQUZlQHSvLIjZKDhB5fqngr8WWnfqIuzb3GRZDgXfGP8UN4mzbmUhtq7N+Sj5qNp1gq8VFiD7WfUZba36n20ahaVo7PPf4OUdjXwXTgnQsO+0rPkLTGh81957Yx2KLaqThTBrG4eplK1QMknrt7yDoq7hfkmx+X4fmrWs8aek5eNKrQFsCe1pAiII/bpQZlAaJ/8vOx6hDP7AtrMExPocZtvqQMKDVq2gVaAE4zR8TYXFYUJEtDp76w1a1od96iMj/ZkI6aa5bUBH5Zp/KN9uu+lnK4n5yZnNrgg6YA8z9JWAwU0i3A==;5:UcpObEsbp63nDbhtQYumoeyR0/OBJ2jGGYn5hc3F/UmvAHHnpRQ6QHW4nP80VaOV5SZ+sbiGw1HP2FFrc2rHPZs+ZAp4/kUOEk24X/8LbUopTMgFH2+wmGCzA0IDT5uCsI86X4jdzsZmJ7kwBrFxf/2cG8TvRWspsGz7G7xiMFA=;24:gP4HkSbXqQh3zKDKBj63yV8KZQDeGasyj7sWaQxZr5CxUSV8fXo9IHplVovp5mMiZJRC5QiK9KmVViYdnr8ApZ4DYYQ0VL5C1Ri4IIAHpVI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;7:Y2FlDD+fHnNGFbeG1cXD9OVwCq4WzrmlNHbb8kwP9lKCVtrgdSbTbw1fySaHfpX9+0N6Ky0vUBX07V8m7bRYtHfQdqYORFWPTK1E7s0dNnzF0U3pQ8IsIaJ4wa/0+ycA8wGIQQlPFVrJbZMfcF5G4AprrcXSd7fAMcbzePdVuZTn5zR6EYENCNs/D1mL5YM/ZbQMoygS5D+MVUbqHEVNRTCaf10XVg9yME/ACZWDiyqkpVhC5Ug+alfCX1fkH2pB
X-MS-Office365-Filtering-Correlation-Id: 8333a0b6-38b7-4028-bac9-08d5a6102dcb
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:11:15.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8333a0b6-38b7-4028-bac9-08d5a6102dcb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-04-19 at 17:02 +0530, Naresh Kamboju wrote:
> On 12 April 2018 at 00:05, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Leonard Crestez <leonard.crestez@nxp.com>
> > 
> > [ Upstream commit 79e498a9c7da0737829ff864aae44df434105676 ]
> > 
> > These bits seem to be lost after a suspend/resume cycle so just set them
> > again. Do this by splitting the handling of these bits into a function
> > that is also called on resume.
> > 
> > This patch fixes ethernet suspend/resume on imx6ul-14x14-evk boards.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/net/phy/micrel.c |   42 ++++++++++++++++++++++++++++--------------
> >  1 file changed, 28 insertions(+), 14 deletions(-)

> arm32 x15 device booting 4.9 kernel shows kernel warning and
> the network is not working on the device.
> 
> Linux version 4.9.95-rc1 (buildslave@lkft-01) (gcc version 6.2.1 20161016
>  (Linaro GCC 6.2-2016.11) ) #1 SMP Tue Apr 17 19:12:22 UTC 2018
> 
> Boot log kernel crash log:
> --------------------------
> [   13.766589] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   13.805441] net eth0: initializing cpsw version 1.15 (0)
> [   13.930334] Unable to handle kernel NULL pointer dereference at
> virtual address 00000008
> [   13.982009] PC is at kszphy_config_reset+0x1c/0x150
> [   13.986909] LR is at kszphy_resume+0x24/0x64
> LAVA job id: https://lkft.validation.linaro.org/scheduler/job/187429#L3341

Looking at this dump I'm guessing that phydev->priv is NULL at the
start of kszphy_config_reset and this really shouldn't be happening.

The phydev->priv field is initialized by kszphy_probe but your
particular phy (KSZ9031) in linux-4.9.y does not seem to have .probe =
kszphy_probe assigned in the struct phy_driver ksphy_driver array.

In upstream this was added by commit bfe72442578b ("net: phy: micrel:
fix crash when statistic requested for KSZ9031 phy"). The message for
that patch claims to fix a kernel crash on this command:

    ethtool --phy-statistics eth0

Looking at the code this issue should affect linux-4.9.y on your board.
Naresh: can you please check?

Commit bfe72442578b was not tagged or selected for stable but it seems
to be a more serious issue.

BTW, the original patch was 2nd of a series, actually making imx6ul-
4x14-evk correctly suspend/resume ethernet in linux-4.9.y also requires
1st commit e6f4292ae0a1 ("ARM: dts: imx6ul-14x14-evk: Add ksz8081 phy
properties"). But this is not a terribly important fix.

--
Regards,
Leonard
