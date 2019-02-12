Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEEFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC9B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="H4tLjzFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfBLILQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:11:16 -0500
Received: from mail-eopbgr90059.outbound.protection.outlook.com ([40.107.9.59]:21632
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728289AbfBLILP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTq6dYtK6m0uOOLnIE12fYiaDa5KOgq0BeRO/NxPxtY=;
 b=H4tLjzFSWS/KhQd4yRxEbR7/F3x1lHZqj6/bAG8spoaFqBCdG+sTVjDIDAgLnuAIsdajWMh/QbBc/HM76N6Qwi62QrZ/+CRdmHNeHgQ81FiVuJODl6hyqWvXhBgxDtBH0ANtsX35qPnDejM86WuEzc94TcrM1U0+svDaQZ3hH7M=
Received: from HE1PR06CA0127.eurprd06.prod.outlook.com (2603:10a6:7:16::14) by
 PR1PR06MB4731.eurprd06.prod.outlook.com (2603:10a6:102:f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 08:11:11 +0000
Received: from VE1EUR02FT022.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::202) by HE1PR06CA0127.outlook.office365.com
 (2603:10a6:7:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.19 via Frontend
 Transport; Tue, 12 Feb 2019 08:11:11 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; the-dreams.de; dkim=none (message not signed)
 header.d=none;the-dreams.de; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 VE1EUR02FT022.mail.protection.outlook.com (10.152.12.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Tue, 12 Feb 2019 08:11:10 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 12 Feb
 2019 09:10:57 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Tue, 12 Feb 2019 09:10:55 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Wolfram Sang <wsa@the-dreams.de>
Reply-To: <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>, Peter Rosin <peda@axentia.se>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] i2c: ocores: add SPDX tag
Date:   Tue, 12 Feb 2019 09:10:56 +0100
Message-ID: <1711378.xRUdGe1i3t@pcbe13614>
In-Reply-To: <20190211165454.4l5r2alhlxzvglxk@ninjato>
References: <20190211164913.5988-1-federico.vaga@cern.ch> <20190211164913.5988-5-federico.vaga@cern.ch> <20190211165454.4l5r2alhlxzvglxk@ninjato>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:PR1PR06MB4731;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 204747f9-ee6e-45a5-ab37-08d690c1a62a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:PR1PR06MB4731;
X-MS-TrafficTypeDiagnostic: PR1PR06MB4731:
X-Microsoft-Exchange-Diagnostics: 1;PR1PR06MB4731;20:MoSH7cK1M2byopYbP3f+tSqqurDeK7MSzPdFnBW3iIPPRIEaPoEeQTAnI3XBz8eFWS/xDfyGE1n9mqmUnyV24Fn0wTtK7ZVVD0DGunIdT0yjo7uAO0NSKog+zKhWibQyVLNc+Fc9WcewfSTwEvDZMETj9X020Mo0VTn+NJCfDR7YGAu/iK+uV+2kH7VD0EhE6ub0lqvRwfuwIYJkK/NJ7KJDMrgyRiSlPLjlXAzYgn7RS6n7EFIOdY2m5DunJq0gG4zHXoP8EF1TMcNkpxXBUq7RIg9F5HXLyTckeOBznSdI0GXEsxnMpC/3gC+E0ARGJpw2kX5OvgzwxW4p/73ijvZAXJJk483RW5SVvs8WaI3Jtj1oqjvepC1SkFnq7+pqQIQsT2bWQYwEPTjp8q1153F0rHxCX0v7iMWtRIkDP1XzzbnNjhBxFyS/skFC99KMZvL3S8I7mRjt6NFQEVQhDr2TlRI4VE3RVunaYFjGbqQ5ZNOlRNxvMXsdXALrqr0D;4:wSpq5sJ6OVAs9ojBYOdo6Sa+wu15jIuCJBCZXpV8bgFSwoSEMY5LDzzIxYSeTh7x9Q7xI3fqliGzhMhqbPWZYYJtvwt4b3+FLbVBUyLVe/sI1qoQ33D/hKbaIQHcJfdffk9vKy2id10ONMZIYRry0h+b1iQSR+wQ3jaY7D7qlZ0NMVp0bfhJ43+HIBKG6C9QJcmJi4tlJQMmyseH5dqwbVs3rO+CdGg7R27a3S7WQ9hWTIP4HuBYBvBhzsfwcUwtriqRQbdtISaiUS81C1y/Pvv/eZgoaLj22aOJHdRLhtI=
X-Microsoft-Antispam-PRVS: <PR1PR06MB473174163B590716D181080EEF650@PR1PR06MB4731.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0946DC87A1
X-Microsoft-Exchange-Diagnostics: 1;PR1PR06MB4731;23:d1LBD3kuP5bCBpaDgg1DN7MEJkryLdHsvROMvona1tg46OnmkjNo39p/VmwO1ENWwaEhZPROZRaMGw/YrWNGQEJTLmRSK05e1hjd7uRFaEbx8+shGTJ3pWo3AI8hPo+xibJBBndD3ifKRrUvsq1T0pKiwMssSYSSoeBX2cG2GU5Js+FNLC0+Cv5wCjYOQXfv;6:Kvol0MpAHpFDVaRs+cFIe4Yu0mUxxqcwuejHyYSp0McvqHuCONJQErqx3YUMkSi/posRWGblgNvi7NzArV3rCnIOLLG5YOgSxaYnLAaR3OTupDXcP/bzcNN/V4VnuqU3Dr3yRq0T1XFzr35LSDlQyGHzlDHvSALO35Og7FhhrMy+V/sJURPsw/BtgqwJL1cQx0FPxyNuht8sIB+RGoKD06/662ckE96LheFqP/dBItjdB8KpMVvBpNuKhA2+gpaq/djrDKKTj4OX4p0ajFwE5CoJU0Kb4fdyKSVA/k5tmCo8TMNs4BtQbxy/CyYlc5jsCjIEduVWM6NnF2w6IASJqPjVKDi0qIctHR6ePyGNzKnBRSg9t1UvkowVWU2gMzbIWqBg0COflH4E48cuM5z0Q6ikCVHitryXBXB7aUsG3DgmbVSHznfzY2XXFkf0k7WkYp2xOF0o6zjwTbww7a4ZTA==;5:QonJQbWts5BzICpOk/wZ/o4uevNy4upvHki3OXXQS6//F1h0GpL+1JEv/Vlfp5OLMy24/PuiVSUz8axsYnOz1bAVnThHipD41nhlCdlVsldYizCVlyCyCEdzaSEznn7HEeF0mvAUDrHVTAxRaruWYXYB2m/X+B9pY/oWDhV3Eh9A6MHaPbV7aRy81dniujfjaKBsJM7T4vPLVwxqYaMFtw==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 14uAWwER4+rlMCtsaUjDSXCVfe7nXYO8yvQZoHA34biahxfYmlS77zeWJQ6Uiwx3OCk78QXmfhWwDro33Z3EuXFIXVu4c/ZgH4KvhbhZP3lYEdDmBekk879SZuaAcQgW5xvzIL55XrF9bBJ0l0sOBL2l6fsindHutp8hemXVLsD7ga8XxgcutK+vdpzPGVzkmvKOhcpVVV1pA/Q6NtGrnZ4//ZD3l7NiUdUfbLmB4OLL1PKwXNxpwGTjR9LwkVJAqzGeXkTIBdctiOQSohkfBFkBQ3bxqUYKmtb4ndHqyI//nrlgtmTfyefesOo0DPwzYzEOTCWi60NE1O6U+Ac/an4AUPzm3vgW0sQ5eT00/tGZJ2Di53fpAeHYnEbekJWXYvDDJI1g5RI+ArmOkAiQThXzGaW2KWWmrfXS6nr37VLxWjKIHs8DCmPKOlsN1KVy/nvkm3eeYjJ7jx6O62zMpYgIuwgzK5HQ/R4NEn5Xhm8HlKdMd+SiQO8okZXT4mMfTvOgU+TQAYhDL3UqXLefLOP5JgUDiGA4/zzyeZSQJuI=
X-Microsoft-Exchange-Diagnostics: 1;PR1PR06MB4731;7:awmzgneGXTKzABcGYtyLnrkdqE2/jmdrFCgbaJinbtiFd018LZ0GtHAx3eDybBvhacOBYyuMeQCRQKgU6+6cLiRZWmlJ+rInzjaH28uPwItAqoyFYj5BWcxQQfAxFb+ZmOlhfUM77CbUe0CP5n5gIQ==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2019 08:11:10.7733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 204747f9-ee6e-45a5-ab37-08d690c1a62a
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB4731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 11, 2019 5:54:54 PM CET Wolfram Sang wrote:
> On Mon, Feb 11, 2019 at 05:49:12PM +0100, Federico Vaga wrote:
> > It adds the SPDX tag and it removes the old text about the GPLv2.
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> 
> I can convert the platform_data header to SPDX again. No need to resend
> because of that.

Sorry, and thanks


