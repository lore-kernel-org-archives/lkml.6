Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDECC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3092E2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OgNP2gf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfAXQhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:37:23 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52286 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfAXQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:37:23 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id C9D8B10C1895;
        Thu, 24 Jan 2019 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548347842; bh=ln8KqpX7AWcfWID25THBGBuuE58G8IYtV6l/j2DrZUw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=OgNP2gf2GWkHJQkgaxg29ru+dBvVf/iB18lPb3vRSyRNxoO2jOEMoco2OgmxHsYgm
         5hQP9Nwrl1Ix5+EY8ExJW48PJ+ht5tFrSbjlLNtAGqpqvkwBIXtASfw0Sbh1H4vmeN
         +mkNFMLNdId5ubUyCwPQ3sm4U6Z60q083KPxQ8EM9aHx4xnnvrb7qeCnDTYwZk88e6
         Xwgo/GDaeHXND589g8CwgKGWvNn6oGPPbLHpwhsm/yoeQUs3bh94FNkS3PPp9zYW0k
         Ixq9l1p54MmGXSzRvY+wivhK38ErpKKWistZCN5cNk2E+lYHPGOEYrs4siDDMd+I2+
         TsodSO7rElrEA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9652DA005D;
        Thu, 24 Jan 2019 16:37:22 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 08:37:21 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 22:07:19 +0530
Received: from [10.10.161.70] (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 22:07:21 +0530
Subject: Re: [PATCH v2] ARC: [scripted] fix node name and address spelling
To:     Rob Herring <robh+dt@kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.kernel
References: <20190124121703.2337-1-abrodkin@synopsys.com>
 <CAL_JsqLfe0YN9ytYfE=quuqSpNgavGhr5rDc42SirrUfYXO66g@mail.gmail.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQuQINBFEffBMBEADXZ2pWw4Regpfw+V+Vr6tvZFRl245PV9rWFU72
 xNuvZKq/WE3xMu+ZE7l2JKpSjrEoeOHejtT0cILeQ/Yhf2t2xAlrBLlGOMmMYKK/K0Dc2zf0
 MiPRbW/NCivMbGRZdhAAMx1bpVhInKjU/6/4mT7gcE57Ep0tl3HBfpxCK8RRlZc3v8BHOaEf
 cWSQD7QNTZK/kYJo+Oyux+fzyM5TTuKAaVE63NHCgWtFglH2vt2IyJ1XoPkAMueLXay6enSK
 Nci7qAG2UwicyVDCK9AtEub+ps8NakkeqdSkDRp5tQldJbfDaMXuWxJuPjfSojHIAbFqP6Qa
 ANXvTCSuBgkmGZ58skeNopasrJA4z7OsKRUBvAnharU82HGemtIa4Z83zotOGNdaBBOHNN2M
 HyfGLm+kEoccQheH+my8GtbH1a8eRBtxlk4c02ONkq1Vg1EbIzvgi4a56SrENFx4+4sZcm8o
 ItShAoKGIE/UCkj/jPlWqOcM/QIqJ2bR8hjBny83ONRf2O9nJuEYw9vZAPFViPwWG8tZ7J+R
 euXKai4DDr+8oFOi/40mIDe/Bat3ftyd+94Z1RxDCngd3Q85bw13t2ttNLw5eHufLIpoEyAh
 TCLNQ58eT91YGVGvFs39IuH0b8ovVvdkKGInCT59Vr0MtfgcsqpDxWQXJXYZYTFHd3/RswAR
 AQABiQIlBBgBAgAPAhsMBQJbBYpwBQkLx0HdAAoJEGnX8d3iisJewe8P/36pkZrVTfO+U+Gl
 1OQh4m6weozuI8Y98/DHLMxEujKAmRzy+zMHYlIl3WgSih1UMOZ7U84yVZQwXQkLItcwXoih
 ChKD5D2BKnZYEOLM+7f9DuJuWhXpee80aNPzEaubBYQ7dYt8rcmB7SdRz/yZq3lALOrF/zb6
 SRleBh0DiBLP/jKUV74UAYV3OYEDHN9blvhWUEFFE0Z+j96M4/kuRdxvbDmp04Nfx79AmJEn
 fv1Vvc9CFiWVbBrNPKomIN+JV7a7m2lhbfhlLpUk0zGFDTWcWejl4qz/pCYSoIUU4r/VBsCV
 ZrOun4vd4cSi/yYJRY4kaAJGCL5k7qhflL2tgldUs+wERH8ZCzimWVDBzHTBojz0Ff3w2+gY
 6FUbAJBrBZANkymPpdAB/lTsl8D2ZRWyy90f4VVc8LB/QIWY/GiS2towRXQBjHOfkUB1JiEX
 YH/i93k71mCaKfzKGXTVxObU2I441w7r4vtNlu0sADRHCMUqHmkpkjV1YbnYPvBPFrDBS1V9
 OfD9SutXeDjJYe3N+WaLRp3T3x7fYVnkfjQIjDSOdyPWlTzqQv0I3YlUk7KjFrh1rxtrpoYS
 IQKf5HuMowUNtjyiK2VhA5V2XDqd+ZUT3RqfAPf3Y5HjkhKJRqoIDggUKMUKmXaxCkPGi91T
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <082c0b8a-13fc-d30a-67fe-13011cc52f5f@synopsys.com>
Date:   Thu, 24 Jan 2019 08:37:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLfe0YN9ytYfE=quuqSpNgavGhr5rDc42SirrUfYXO66g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey, Rob,

On 1/24/19 8:28 AM, Rob Herring wrote:
> On Thu, Jan 24, 2019 at 6:17 AM Alexey Brodkin
> <alexey.brodkin@synopsys.com> wrote:
>>
>> From: Alexey Brodkin <alexey.brodkin@synopsys.com>
>>
>> 1. Remove "0x" prefix from unit-address of node names
>> ----------------------->8------------------------
>> sed -i 's/@0x/@/g' arch/arc/boot/dts/*.dts*
>> ----------------------->8------------------------
>>
>> 2. Make all hex addresses lowercase:
>> ----------------------->8------------------------
>> sed -i 's/@\([0-9A-Za-z]*\)/@\L\1/g' arch/arc/boot/dts/*.dts*
>> sed -i 's/0x\([0-9A-Za-z]*\)/0x\L\1/g' arch/arc/boot/dts/*.dts*
>> ----------------------->8------------------------
>>
>> Inspired by [1] and the like.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/13612017/
>>
>> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> ---
>>
>> Changes v1 -> v2:
>>
>>  * Convert all hex addresses to lower-case [Rob]
>>
>>  arch/arc/boot/dts/abilis_tb100.dtsi    | 58 ++++++++++++++++----------------
>>  arch/arc/boot/dts/abilis_tb100_dvk.dts | 14 ++++----
>>  arch/arc/boot/dts/abilis_tb101.dtsi    | 58 ++++++++++++++++----------------
>>  arch/arc/boot/dts/abilis_tb101_dvk.dts | 14 ++++----
>>  arch/arc/boot/dts/abilis_tb10x.dtsi    | 60 +++++++++++++++++-----------------
>>  arch/arc/boot/dts/axc001.dtsi          |  6 ++--
>>  arch/arc/boot/dts/axc003.dtsi          | 16 ++++-----
>>  arch/arc/boot/dts/axc003_idu.dtsi      | 16 ++++-----
>>  arch/arc/boot/dts/axs10x_mb.dtsi       | 22 ++++++-------
>>  arch/arc/boot/dts/hsdk.dts             |  4 +--
>>  arch/arc/boot/dts/vdk_axc003.dtsi      |  4 +--
>>  arch/arc/boot/dts/vdk_axc003_idu.dtsi  |  4 +--
>>  arch/arc/boot/dts/vdk_axs10x_mb.dtsi   | 18 +++++-----
>>  13 files changed, 147 insertions(+), 147 deletions(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>


Thx for the quick look at this. I've added this to ARC for-curr !

Thx,
-Vineet
