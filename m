Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E66C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B4420661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B4420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeIDRBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:01:09 -0400
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:52924 "EHLO
        2.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDRBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:01:08 -0400
X-Greylist: delayed 16257 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 13:01:08 EDT
Received: from player735.ha.ovh.net (unknown [10.109.159.20])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 393BC179DEA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Sep 2018 09:49:12 +0200 (CEST)
Received: from [192.168.0.230] (22.220.201.77.rev.sfr.net [77.201.220.22])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player735.ha.ovh.net (Postfix) with ESMTPSA id 355211600BB;
        Tue,  4 Sep 2018 09:49:01 +0200 (CEST)
Subject: Re: [PATCH] ARM: dts: imx6ull: update iomux header
To:     Shawn Guo <shawnguo@kernel.org>, Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
References: <1535606405-8099-1-git-send-email-Anson.Huang@nxp.com>
 <20180903022642.GE3850@dragon>
From:   =?UTF-8?Q?S=c3=a9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sebastien.szymanski@armadeus.com; prefer-encrypt=mutual;
 keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwH8EEwECACkFAlNfZLECGyMFCQlmAYAHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIX
 gAAKCRCwminogTJk4ss0CACpxtvYO1rCYNtc/j/6fkDsuKKwGtijixHU+C3N+EAJVoHSCdRM
 /PMtyN1fa+94XbW4LHQpZthkXd4kBpcf0aNtrS51193/YZHK5jLpJlUMKLGgU5VHXguakOOF
 ZWptlUCEqZaQ4gR8CUxPZi4urNAg/ORxCiVW2oMO/8GRhoZ+r14QNDGFVphbdlk/4YyY3wr7
 scDKTrRdkGw7kJElAp61I/B2KSbhnvF7U6H646a12/7bm6IEOAWbntoPcBg1h6irlCiNqfxs
 Zfy3r6rVRy840Dl7ldoUzOs7Eon8lUQilr9UorOHBF4NaBTpyD75DtvjRQsF2qV+R1RGS/Em
 IvrjzsBNBFNfZLEBCAC6O44V3Xa1wU0buUgI3pVed48hwSU1/7zeJy/1W21v7GnGvjSYw0sc
 eQwZqLWW0HViMmYkiI1P8Z00RL7Q65emXkrClne2aoromOH0kc8LkKfa3dMqkbsXrK1nsiQd
 cwknRLy8igEhEbfp8ZDgPiMyeMtai7b51q/ki9QF4EzMPk5MsCiAwkVh0yGGrNdZXRo/NoDi
 KWHl52qXjSx30+BEMINDXlmB8pycQEFol+Wj5cNLkqQEErAV0BSHt36aL3jEp1yvjxtgQTs3
 sWL+6+Eu9GurBfbIE0z6XyqlGqqgvrtfm1F+mpUwCoRiicsGhelYqi5YGPD38KIUsgJapU0T
 ABEBAAHCwGUEGAECAA8FAlNfZLECGwwFCQlmAYAACgkQsJop6IEyZOKWTgf/RbOvtKW77EXW
 XBzh04rfkW6prOlbJaIMUjVKZZ1D2OOpAxJbq80whJqCoJ+oVh7uAteozgX3U5TnL7fRx6HP
 zhyidiwKCOXEeTsFrRHEpTOCJYbPz8MTsK14ogz/aUlImt0HbxTaVHz5m65wWM8doCqOj2J9
 Vf12NNpfTxkotmM0QJQAIcEg10RfT3DLG1a68sdghM5rlz/b8mr/wjtOVxYX1TWKMvilCdQy
 YT8NNFcBwMEy5Jt2SXpeASY0CIXGwqqCBLqmQMhh3VcmibIbBBB0hIg4f56Vfn7v8ouFmbYS
 G0Q3TMIWXxYn91KiMXeox+Wsic2Ocw/KpZ/tus0JXQ==
Message-ID: <eaa5e1cf-04e6-f11f-e7f8-0ff95b97ab5c@armadeus.com>
Date:   Tue, 4 Sep 2018 10:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903022642.GE3850@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4105031061117555758
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrheejgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 04:26 AM, Shawn Guo wrote:
> Add Sébastien for a cross check.
> 
> Shawn
> 
> On Thu, Aug 30, 2018 at 01:20:05PM +0800, Anson Huang wrote:
>> Update i.MX6ULL iomux header according to latest reference
>> manual Rev.1, 11/2017.
>>
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

-- 
Sébastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26
