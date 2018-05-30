Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937297AbeE3I2C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:28:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39795 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935925AbeE3I1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:27:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180530082751euoutp02db9f1f7ed8dedd7e31fbd9adb6665ef9~zXr6Tu6RR1352513525euoutp02F
X-AuditID: cbfec7f5-b45ff700000028a9-0a-5b0e60855bd3
Subject: Re: [PATCH 08/12] drm/bridge: tc358764: Add DSI to LVDS bridge
 driver
To: kbuild test robot <lkp@intel.com>,
        Maciej Purski <m.purski@samsung.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Wed, 30 May 2018 10:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201805301553.AcTypuC4%fengguang.wu@intel.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0yNYRze+91rnfY6Rb9ym2OMRrmEl9Iwts/aaDYbanHok6br+Sq3Lbmk
        OqTkloNya7VTVEdKUbZqWpQjJLIuaKY4M46TuevrY/rv+T3P83ve57e9Aq09wXkJkTEJkiFG
        H6XjnJnKu1+tM1M3uYbMyj7iTjIfNFNkf7qNJeW5pSzJb3zAkieODxzJ6clmyNvuNobc7ThG
        k6zX72hitZbxpHX/e55kHLvCE8vrpyx5XHOOI7nWOooMHHjFkQv9nQy52tjFk4KONoqk1jby
        JPd4P0e+1uQxS8aIPbW8WJJXgsTHRzMpsdrUxYtn08+w4uXb/ZRoMWdwYtVgLyv2HG6ixOtX
        9opHK8xItFsmBLtscA4Il6IikySDb+Am520Vl1P5uBfjdlYf6kMpqGq0ETkJgP2grDcHGZGz
        oMVFCJ5kFdHq8BnBl6tWVh3sCL41d7P/Vl46BnhVKEQwaLTwiqDFNgTltxYo2A0Hw8XfpqEo
        QXDHQeDojlX8NE7jIKMuc9jP4enw8/pzTsEMngIfygqG+dF4HZRnf6IVrMGjoPlMH6PkOGF/
        +NYbrtA0nghVtnO0ij2gsy+fUvIBtwjQcuQZpfg1OAnai1ernZdD2jszr2I3GGiq+IvHwe9q
        ZVfBMnw6mfI3JwXB2cJmRhX8oaGpjVUy6aHOpTW+Kr0U3vwwD1cD7ArPbKPUOq6QU3maVmkN
        pB/Squ5J0NN6g1axBxQ8dHDZSGcacaNpxGGmEYeZ/r97ATFm5CElytERkjw3RtrhI+uj5cSY
        CJ8tsdEWNPRX7/9qctxEdT821yMsIJ2LZtY6TYiW1SfJu6LrEQi0zl2TWOsSotWE63ftlgyx
        Gw2JUZJcj8YKjM5DEzYteYMWR+gTpO2SFCcZ/qmU4OSVgsR95SXnVy/OsreErwg9VbmidtlN
        Pz7I5vbxp+NXrrBwXvvUwlDzdvFaQHxCpHbNw4MrNxsbiG+CX/HKQVL/dmb32i5j0SufR6s8
        1yxh/Sd7rp8z3fuO/rzYmXqpdcH4svz0QGZraPHe+HvzfRpeeHlmTo632zt0AQ3fw3aEHpiR
        vGiPjpG36Wd70wZZ/weu6LdWpwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH931+k9PTId9ZK90qaeu4Q/eVWPrrGVtTVitqufGEdT90z51S
        axn90DWF2uLSnQ21TKVjSagm82PJjRNDnGIJXa0Zo1WLU5v/Xvvs83rv89neDC5+QPox6Ro9
        r9MoVRLKnXj7p31056Ukz8TgzzY/lN/diaGcPCeJnhY/IZGltZtEfXPfKVTkKCDQl9EeArUN
        FOLo5vgMjmy2Ghq9y/lKo2uFFTSyjveTyP6ilELFtpcYms79RKGyqSECPWodoVHlQA+GLje3
        0qj41hSFFl+Yib3rOUczzVWbqwFnv5GPcQ2mEZq7m1dCcuVNUxhnrbpGcfXzYyTnuN6OcbUV
        F7kbdVWAm7VujPNIkO7RaQ163j9NK+gjJYkyJJfKwpFUHhoulYUoju+Wh0mCovak8Kr0TF4X
        FJUkTasrv0xnDG8423BlAmSDeh8jcGMgGwo/zk3TyyxmKwHszZOuzH1ho8WJr7AX/NVvpIzA
        fWlnBkD7gskleLH74Y+RD4QRMIw3GwvnRrXLOzh7nYL59qvEitAJoOXhT1cSxQbC37WD1LIg
        YqNgrsV1BMFuhd9rKl2ZPuwRmGOudrGIXQc7SyZc+W5sBPw5lrI8xtkA+Mvci6/wJljvLP3H
        vnBowoIVALFplW1apZhWKaZVShkgqoA3bxDUqWpBLhWUasGgSZUma9VWsFSSZ22Ldc+B8Vt8
        C2AZIPEQBR8RJYpJZaaQpW4BkMEl3iJDs0eiWJSizDrH67QndAYVL7SAsKXfCnE/n2TtUuU0
        +hOyMJkChcsUIYqQXUjiK7IFZyWI2VSlnj/F8xm87r+HMW5+2eDOfG2E/CoZM/l6OKCGts8+
        rvccb9gXcyx9jYOYTBa2UEezAzUdtL9oLlB1cKxp8/nY7WryxwYsO7pyqFQVrUC+atOBM32R
        varU3Yc7txXO3PN/aBoMKl9blON0NHZZ+iKd75XTOoZue3Oyq934iroQmnXofpx1If5ix+3T
        0eUSQkhTynbgOkH5F7Gx75g6AwAA
Message-Id: <20180530082748eucas1p1eede54cce4a257bf2795ac8474f9a9d3~zXr4CtkHD0946509465eucas1p1J@eucas1p1.samsung.com>
X-CMS-MailID: 20180530082748eucas1p1eede54cce4a257bf2795ac8474f9a9d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180530074642epcas1p31772422454439c0a4ed636f620a3c4bc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530074642epcas1p31772422454439c0a4ed636f620a3c4bc
References: <1527500833-16005-9-git-send-email-m.purski@samsung.com>
        <CGME20180530074642epcas1p31772422454439c0a4ed636f620a3c4bc@epcas1p3.samsung.com>
        <201805301553.AcTypuC4%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,


On 30.05.2018 09:45, kbuild test robot wrote:
> Hi Maciej,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on next-20180517]
> [cannot apply to drm-exynos/exynos-drm/for-next robh/for-next drm/drm-next v4.17-rc6 v4.17-rc5 v4.17-rc4 v4.17-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Maciej-Purski/Add-TOSHIBA-TC358764-DSI-LVDS-bridge-driver/20180530-011258
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/gpu/drm/bridge/tc358764.c:193:14: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [addressable] [usertype] addr @@    got ed] [addressable] [usertype] addr @@
>    drivers/gpu/drm/bridge/tc358764.c:193:14:    expected unsigned short [unsigned] [addressable] [usertype] addr
>    drivers/gpu/drm/bridge/tc358764.c:193:14:    got restricted __le16 [usertype] <noident>
>>> drivers/gpu/drm/bridge/tc358764.c:197:24: sparse: cast to restricted __le32
>>> drivers/gpu/drm/bridge/tc358764.c:175:5: sparse: symbol 'tc358764_read' was not declared. Should it be static?
>>> drivers/gpu/drm/bridge/tc358764.c:204:5: sparse: symbol 'tc358764_write' was not declared. Should it be static?
> vim +193 drivers/gpu/drm/bridge/tc358764.c
>
>    174	
>  > 175	int tc358764_read(struct tc358764 *ctx, u16 addr, u32 *val)

add static

>    176	{
>    177		struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>    178		const struct mipi_dsi_host_ops *ops = dsi->host->ops;
>    179		struct mipi_dsi_msg msg = {
>    180			.type = MIPI_DSI_GENERIC_READ_REQUEST_2_PARAM,
>    181			.channel = dsi->channel,
>    182			.flags = MIPI_DSI_MSG_USE_LPM,
>    183			.tx_buf = &addr,
>    184			.tx_len = 2,
>    185			.rx_buf = val,
>    186			.rx_len = 4
>    187		};
>    188		ssize_t ret;
>    189	
>    190		if (!ops || !ops->transfer)
>    191			return -EINVAL;
>    192	
>  > 193		addr = cpu_to_le16(addr);

It should be changed to:

cpu_to_le16s(&addr);

>    194	
>    195		ret = ops->transfer(dsi->host, &msg);
>    196		if (ret >= 0)
>  > 197			*val = le32_to_cpu(*val);

le32_to_cpus(val);

>    198	
>    199		dev_dbg(ctx->dev, "read: %d, addr: %d\n", addr, *val);
>    200	
>    201		return ret;
>    202	}
>    203	
>  > 204	int tc358764_write(struct tc358764 *ctx, u16 addr, u32 val)

add static


Regards
Andrzej

>    205	{
>    206		struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>    207		const struct mipi_dsi_host_ops *ops = dsi->host->ops;
>    208		u8 data[6];
>    209		int ret;
>    210		struct mipi_dsi_msg msg = {
>    211			.type = MIPI_DSI_GENERIC_LONG_WRITE,
>    212			.channel = dsi->channel,
>    213			.flags = MIPI_DSI_MSG_USE_LPM | MIPI_DSI_MSG_REQ_ACK,
>    214			.tx_buf = data,
>    215			.tx_len = 6
>    216		};
>    217	
>    218		if (!ops || !ops->transfer)
>    219			return -EINVAL;
>    220	
>    221		data[0] = addr;
>    222		data[1] = addr >> 8;
>    223		data[2] = val;
>    224		data[3] = val >> 8;
>    225		data[4] = val >> 16;
>    226		data[5] = val >> 24;
>    227	
>    228		ret = ops->transfer(dsi->host, &msg);
>    229	
>    230		return ret;
>    231	}
>    232	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
>
