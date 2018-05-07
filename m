Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AB8JxZrI8wQUXji/5fnniu8id7wSRH2yCLn25VM2b91UHXgos3ECmH2DEfjde+nhTcN3YUG7HI/z
ARC-Seal: i=1; a=rsa-sha256; t=1525703223; cv=none;
        d=google.com; s=arc-20160816;
        b=EhthqGD/zeiAj1AL3qbkvVtLzgUEFenre9XIXagGzhF2LKHW+akZG16OSMTGuhdMZU
         J266V/9ay0Lyn6n2RMK3saD+XSDIu/XLumczb68l8/cRrK4ZKpLLvrZWjojW71wz75LP
         3NcaxuI3gKbOHRnVALLYUDSDGXk/spTIhBaEhSKjqKhHESCGRuIL5nzw1kH7SqmLj45O
         nBvpvrAvjOLv3rgnzEIUIY7yt3MYiXZ2ZnRf1vEDfrG8WiSsvzq3gyDzYacbLOFTYOST
         fNK+zZPchAiRPO4rD8pDZPhcAiAdwJ9CrYMAu5fq1vvnckl6jjLDnuSY4eXkV6JekaDW
         PyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=C7VvINFTCSFMO0PPEhVneZhPW9BAeNqB0c27PO2jx54=;
        b=pccWpxm0+3DdiIJYvMyuvqjO/J6CCRDlbNwkENsoUwrpfDAYzM19w0S7sUZ3qi8GDS
         jU15a3TlSq/LYlqBp+O0e9sV01gsumyql5dAmOjMHkBj6CeakkG1wbMQOMF/RdBNihBP
         G16ZKTAG0wGNsr527VUJuGxgYz7bw8eIDhZfRE+/OGPvTaW1NQiw9YCIf7d6WrlvZ5nF
         WxorIc4bEGdMXGgZ/kQSaLGOSOj43ZJDvZT1R1v1JxRQEIFsGbyv3xuRol4mb+euXi6I
         laGmFzMuQu0SMkztVUXLk/DMKDAGLGPadOaoYc5oy9UgV1Ajo/HdfXCxDAxykBuocg7A
         g74w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.21 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Benjamin Gilbert <benjamin.gilbert@coreos.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] powerpc: wii_defconfig: Disable BCMA support
Date: Mon,  7 May 2018 16:20:19 +0200
Message-Id: <20180507142019.32669-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507142019.32669-1-j.neuschaefer@gmx.net>
References: <20180507142019.32669-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GhHbqt0NSwQfab41OrI21SxyRrcHjoFTcNGsUKXvBhI4z1xGVo1
 uenUAMz3Hs8FrCS6BMmnrbupQ1sPg6os5/a2rVKxs6gEtEBHHI8F3j+nFveo8MRPQkCzXqD
 9ZWAXj/WLm8jiXGDmDT6vOjjV08WPMBBZfkJKLsAPhSK9Dz+arRk+A6P3Z7SK1+4YyF+iGY
 o9D3F0fmwgLOO/ejKuz5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X0RwhDIft3Y=:/VXNV6JnQR5+z62HMIBxvc
 dXGSZIu/sHc7GrWVTrubvbxVahEbgvgkdxqNGSObTqhnoQg0QmwhvLfM/bXcjBASyyfSlUX47
 4RgUrhNTK/vfFBuWA0j9HVSRSiK0ONgCK3+if3wWd30U5dZsBoU6vo31j/lkavvlRvOGgWIuy
 cPr3/9TL9XUX6S1ApgIbXQgyk7o20LmL/pOMT/aRJxCMf4E4FzUiyLMUiiehD7CGZoY+B9XjU
 A8hT6gacT1t4CkWbfNM4BbyaMxTXe7lBGtnwisM75UYd6Raa76mjBZfjFTgQqjMBkPmbB18SL
 dqNxVJQPCwMl7TnD0xEvchf+Qk7xOITT4zocczhqRx4VGlYkHKMKTiVClJDIsRFMLqBsIZX+G
 0tOe5VQRWffEiXEr+d4N4hnXbMWgO5zKoLdE92fEJgADy5g/mqpNe/Y8LpDO4ck00qUrRHT8D
 VyqyUKutyYdh6PNRziKo2kMGybG/eEsHook/KdmjuWLFET4kGuZKwO9gAbklPHcjD6dRhxHx1
 vO8hbPu3qJayWzKytTd1pu5rgq2OspaXGL8tsC1NkMfOpVCEF1uyYlnEZcPvRzRX47kyORY0e
 s4oWkVVpy5SGEOgX25vgMZqm4qKymjwf+rYGeV3FXZz14Yg0w6U1pBch3t63i4/8677fIkx/6
 P2QsYij4deE5WYv52LbxmvX8hgoX8eQ+taM2jvRCa9l4QuAT/waYMC4zJd+JxFc8sFo/rHRP9
 LIQRuZASiQT6ZZp37Kc3ZzUm9fYcCZ0KQIlgK1zLCjCi8tIkvwHzoqT+atdxEth6gwdJCg0jV
 y4OIaqy
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815783407176891?=
X-GMAIL-MSGID: =?utf-8?q?1599815783407176891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The B43 driver only needs CONFIG_SSB to support the WLAN card found in
the Wii. Configure it accordingly, and disable BCMA bus support to save
a bit of space.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

v2:
- Patch added to the series
---
 arch/powerpc/configs/wii_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index a674dd420f0f..10940533da71 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -51,6 +51,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 # CONFIG_ETHERNET is not set
 CONFIG_B43=y
+CONFIG_B43_BUSES_SSB=y
 CONFIG_B43_SDIO=y
 # CONFIG_B43_PHY_LP is not set
 CONFIG_B43_DEBUG=y
-- 
2.17.0
