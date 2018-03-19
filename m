Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbeCSPQR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:16:17 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:50117 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755369AbeCSPQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:16:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180319151610epoutp01bc10d17b4d00eeb814887bcdc045a4d4~dWz3ncPpp2085820858epoutp01G
X-AuditID: b6c32a48-9adff70000000ff0-e8-5aafd439d48c
Subject: Re: [PATCH v2] ASoC: samsung: Mark unused Odroid compatibles as
 deprecated
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <29143fe8-614b-21f7-624a-671207c0822b@samsung.com>
Date: Mon, 19 Mar 2018 16:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180318153512.8343-1-krzk@kernel.org>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7bCmha7llfVRBl9+mFtcuXiIyWLqwyds
        FvOPnGO1OH9+A7vFtysdTBaXd81hs1h6/SKTReveI+wWF1d8YXLg9NjwuYnNY828NYweO2fd
        ZffYtKqTzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyDnzrZitYwF7x+nVmA+Mcti5GTg4J
        AROJOb13WbsYuTiEBHYwSvz79IIRwvnOKDH/7CpGmKpnC86AdQgJ7GaUWDBRFKLoPqPE8q8n
        wBLCAqESH+d/ZAGxRQQ0Ja7//c4KYjMLTGCS2L9NBcRmEzCU6D3aBzaUV8BOYvfCf8xdjBwc
        LAKqEv1bNEDCogIREgunPoUqEZT4Mfke2EhOoBsutL1kgRipKfHiyyQoW1zi2P2bjBC2vMTm
        NW+ZQW6TEHjOJnHm8T8miAdcJB59vc8OYQtLvDq+BcqWlni2aiPUk9USnW1d7BDNLYwSf6Zd
        goaRtcTh4xehnuGT6Dj8lx3kaAkBXomONiGIEg+JFw+OMkPYjhLHdoMcCgqgdkaJx6fWsk5g
        lJuF5KFZSJ6YheSJWUieWMDIsopRLLWgODc9tdiowESvODG3uDQvXS85P3cTIzjhaHnsYDxw
        zucQowAHoxIP70LJ9VFCrIllxZW5hxglOJiVRHifXlkXJcSbklhZlVqUH19UmpNafIhRmoNF
        SZy3LcAlSkggPbEkNTs1tSC1CCbLxMEp1cBYoxwSFMXuKeiutkb74sHPs4T4Mg1rgvuqxduu
        FPH/e/Jh0sSAtAcp/wOYfmnXdp/VMFmuxdt4VfTpX8/unyG6j74lTYsosfFNk7TIZv9isXgh
        w43SlcyFORKGeUb8kzQ8099uSpuq6/Zs1XzV/2a8Ah45V2T/uS1O+vcgt+EAQ3RO3TJ1WyWW
        4oxEQy3mouJEAPKtgXs0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t9jAV3LK+ujDHb+E7G4cvEQk8XUh0/Y
        LOYfOcdqcf78BnaLb1c6mCwu75rDZrH0+kUmi9a9R9gtLq74wuTA6bHhcxObx5p5axg9ds66
        y+6xaVUnm0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBlHPjWzVawgL3i9evMBsY5bF2MnBwS
        AiYSzxacAbK5OIQEdjJKnDqyghnCecgoce7XSkaQKmGBUImP8z+ygNgiApoS1/9+ZwWxhQQ6
        GSXOHhACaWAWmMAkcaCtEWwsm4ChRO/RPrBmXgE7id0L/wFN5eBgEVCV6N+iARIWFYiQ6Fw5
        nwWiRFDix+R7YDYn0EUX2l6ygJQzC6hLTJmSCxJmFhCXOHb/JiOELS+xec1b5gmMArOQdM9C
        6JiFpGMWko4FjCyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzEC42PbYa3+HYyPl8Qf
        YhTgYFTi4XU4ui5KiDWxrLgy9xCjBAezkgjv0ytAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rz8
        +ccihQTSE0tSs1NTC1KLYLJMHJxSDYyahjvOXzmf/0vw7g3BMwc8pUrPd8vt/JG6wLCgLH8f
        z3ReeznxaAEBrpRDV+bmzuRRs0tY4iH/U7QviudDp+z9lWUJR3skZuSVb1C6xyTh4WAe6SlV
        Lfv+IceH43+1z87f5a7JmBggG8l9THT263PrZy3h5TKXqzQKem61/EJcwK3zD7e0iSmxFGck
        GmoxFxUnAgDZ9dckiwIAAA==
X-CMS-MailID: 20180319151609epcas2p1a8349213e2d5788443e4689354892c08
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180318153541epcas4p2229bf9e856b26e0b1f0db778222eb32e
X-RootMTR: 20180318153541epcas4p2229bf9e856b26e0b1f0db778222eb32e
References: <CGME20180318153541epcas4p2229bf9e856b26e0b1f0db778222eb32e@epcas4p2.samsung.com>
        <20180318153512.8343-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18/2018 04:35 PM, Krzysztof Kozlowski wrote:
> diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.txt b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> index f35a2694eb04..e9da2200e173 100644
> --- a/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> +++ b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> @@ -3,7 +3,9 @@ Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
>  Required properties:
>  
>   - compatible - "hardkernel,odroid-xu3-audio" - for Odroid XU3 board,
> -		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board
> +		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board (deprecated),
> +		"samsung,odroid-xu3-audio" - for Odroid XU3 board (deprecated),
> +		"samsung,odroid-xu4-audio" - for Odroid XU4 board (deprecated)

I think we should make it clear which compatible applies to which board.

-- 
Thanks,
Sylwester
