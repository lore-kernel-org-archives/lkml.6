Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbeBFNHO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:07:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33542 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBFNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:07:04 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180206130702euoutp02d284dff684efdc6df5c9ecbfe0b51b3e~QvmaYNbYI1396413964euoutp02m
X-AuditID: cbfec7f5-f79d06d0000031c7-bc-5a79a874fba8
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [PATCH v2] drm/bridge/synopsys: dsi: Add 1.31 version support
To: Philippe Cornu <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-id: <ec4a4255-38f1-6747-4dc4-09ea9f06126d@samsung.com>
Date: Tue, 06 Feb 2018 14:06:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <20180206084251.303-1-philippe.cornu@st.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe89tx+HidVo+mCStIgrSki6nMrOQOEWREEnti406qXkpNg1X
        RGNmzXtZmZ55JRWtyFIzLTM1yFKRylpI3rpodpGZl9BCbdtR8Nvvub3/5/nzsqTSSnuw4dEx
        gjZaE6li5FT1i8n2tTGlevW6J41+XGr7K4J78LUVcUbTEM0Zm1oYbqQnneEqfltp7t24leFm
        Pv+kudyM81zi1SIZV/HFQnMdj3NsbX0zJNd3cZDm2t43UNzlxAQmAPNmwxuK70hLJfhasVvG
        m03ZNN9lqWP4R3/6aL43uZngK4su8FPiM4p/ZMkj+f6JpyQ/WrE0yFkt9zsuRIafEbQ+/kfl
        YXXGAvr0XyqutEYkDegHmYScWMAboMOYNcuL4XVPOZOE5KwSFyMYHh4hpWAUwWvLW2ZuwlzW
        K7OzEpcg6E9dZmcFdoGJaz2UnUm8GgbHMihpeACBochE2AuueC/8asiV2Qtu2EiB5WuOQ4LE
        BgQDuZkOCcY2PlXZyUjP+sPdwkHHsxReCSWpbY5lF+HDUHijH9nZCW+B7MR0UpL2gsZ332bX
        cIf4hE7HGoBbZPB7xEpINwRCQtW3WXaFH81VMok9IdHUSEgDyQhG0l/KpOA6gunhOZ+2wfPm
        N7QksRAyqm/a8qwtrwDTJaXUwkPPg3pK4p1wrzJeJpmRgqD2lZm4grzEeaaJ80wT510hzrui
        AFG3kZsQq4sKFXQbvXWaKF1sdKj3sVNRFcj2DVunm8drUPGLrU0Is0jlrKgR4tRKWnNGp49q
        QsCSKjdFWp5erVQc1+jPCtpTIdrYSEHXhJawlMpdsV196YgSh2pihAhBOC1o56oE6+RhQAs+
        19/PcKn22oPKl2N98K0d7IDzBev2/cz3qojeejIWl6l3nVjh++fO5of+y+MeZnlssohXiZwD
        n5KWPCa7FiAmrz1k/M7HwA/I3fOQuC8gIv9kvs9QSl+2ytfpGqlmDv8Llud3nVuFyhemZx6c
        9J+B+567t34fM9fnB5m7A40qShemWb+G1Oo0/wFc2A8sggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xa7olKyqjDPoWi1n0njvJZLHxyWlG
        i6aOt6wWTYdOsVl8utfPZrHp43tWiytf37NZ/H/0mtVi7qRai86JS9gtNj2+xmpxedccoLIH
        /5ktHrS8YLU4c/UAi0V7Zyubg4DH7IaLLB6X+3qZPHbOusvuMbtjJqvHnWt72Dy2f3vA6nG/
        +ziTx+Yl9R5/Z+1n8dh+bR6zx9Mfe5k9Pm+SC+CJ4rJJSc3JLEst0rdL4MrY07SAteAXS8WK
        HbOYGxhfMXcxcnJICJhIzF55nx3CFpO4cG89WxcjF4eQwBJGiXfTnoMleAUEJX5MvsfSxcjB
        wSygLjFlSi5EzTNGiXP/tzCB1AgLeEm8OTCXHSQhItDCIrH36U2wScwCTYwSV77uYodo6WOU
        +LZzP9huNgFNib+bQapAVthJrFn4ggXEZhFQlVjWewasRlQgQqJz5XywOKeApcTMzn6wOLOA
        vMTBK89ZIGxxiebWmywTGAVnIbl2FsK1s5B0zELSsYCRZRWjSGppcW56brGhXnFibnFpXrpe
        cn7uJkZgzG479nPzDsZLG4MPMQpwMCrx8O5IrYgSYk0sK67MPcQowcGsJMLbN68ySog3JbGy
        KrUoP76oNCe1+BCjNAeLkjjveQOglEB6YklqdmpqQWoRTJaJg1OqgTGhi3lympP6nb+C+18U
        Mdjf2dyyZE5GRJ7n15tON0IPx7m4hc1aVjBzwzq73i+N92a0fYt6r3B0Soj/JOY1Iia/EznO
        lllt1+u79e1/5cMVZf0bRBQ7PTXs7pZrSf9IaGYLe/b/4QHNX//shMomLnnt8tpuzcvZbCZb
        E3S+BAuYnD014YVi7nolluKMREMt5qLiRADdsszS1QIAAA==
X-CMS-MailID: 20180206130700eucas1p241374144e21ed673155a00bda3b34aff
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180206084357epcas1p32e11d1e3c84de7da9d5ba150ded77cdf
X-RootMTR: 20180206084357epcas1p32e11d1e3c84de7da9d5ba150ded77cdf
References: <CGME20180206084357epcas1p32e11d1e3c84de7da9d5ba150ded77cdf@epcas1p3.samsung.com>
        <20180206084251.303-1-philippe.cornu@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.2018 09:42, Philippe Cornu wrote:
> Add support for the Synopsys DesignWare MIPI DSI version 1.31
> Two registers need to be updated/added for supporting 1.31:
> * PHY_TMR_CFG 0x9c (updated)
>   1.30 [31:24] phy_hs2lp_time
>        [23:16] phy_lp2hs_time
>        [14: 0] max_rd_time
>
>   1.31 [25:16] phy_hs2lp_time
>        [ 9: 0] phy_lp2hs_time
>
> * PHY_TMR_RD_CFG 0xf4 (new)
>   1.31 [14: 0] max_rd_time
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

If there will be no objections I will merge it this week.

 --
Regards
Andrzej
