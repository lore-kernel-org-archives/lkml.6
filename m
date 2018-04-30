Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AB8JxZqQtv3JfIYTnhR2HSzm/fgN1IjOkobxm2HF31Yx293tGIj6YTuZphmnIRCINhem52ZsFfmu
ARC-Seal: i=1; a=rsa-sha256; t=1525096159; cv=none;
        d=google.com; s=arc-20160816;
        b=MahyY9BH3V+m0cE1Qsevw4tTzN2KdL9PSqdyT8vNaeYdfIZ5J5bKJJWvUnlK0rOPT5
         zy7Q1bgVgpPYX4CDZj/2UlJjtZuH8WnoUp9/PKVevdGyVGF4LXvFu2qKG/tNczwqnzkE
         vYLQIDxxaymdhEfHyZ/YkbKdhTQLVSSp+wy+4qANDxVZJS8q57U/p8EvFfZlpkTj6jPG
         gnsJ34qojphjYmw4BD6mSAHrWTYkm6jbFJOGOob2m2mKjHRUey4KG0938xKXLppNcjKs
         VeIO3TcA68HUmFzPwBYve2eBfpiZCPF6Hpiq6XJZRL6VXkBP+01gdUaTKrDl5A2KZ1vP
         WagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=mG8TPRbCPTbRCdm+f0YaebaWlAF2KRw+QqTabLQmafY=;
        b=QG2EVLO8l5bz9RsOQnf+IUAcrrsQavd9mCyXxYgPQ4GdH/Q1J/YxeIiVBFx9YvH4lx
         n6IRlUpXc5Ms0n3yTSitUwYG9STqyiwQvGVXyH4Wo8X474LfHEd3riFlZO9YSR+p1fcO
         5bDg1QuJQn4sJDa8DFpFJkDHHbtqQScFTp7vBd72kT9nQbyg4IC0Z41LoZDbwQU+4kw4
         2K4Dwhhs2GNicH+fuYx45s7N6UU6J/lgcOKrqV5RIjh5BmxLA/2GLidv2i/mCWqbt+p3
         Dr1RU2FNrNTkFacMrNpYRuiiTpKPj5KfYQz0efEy3NqqZ8JRYZBPOnRLL772+vACH6Td
         vdOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.15.18 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.15.18 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Benjamin Gilbert <benjamin.gilbert@coreos.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: wii_defconfig: Disable Ethernet driver support code
Date: Mon, 30 Apr 2018 15:42:46 +0200
Message-Id: <20180430134252.17345-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:43/0o+W810eO+5I2x4pVUNOUnaMoJ03BP9caofW8nokLssBzK7l
 s7pVUNEEJYK5AfuMaRiJd1Sw6ELU1O5hDEK7lSzdSAwQ/93LJQrzNb7R+Z6ikOs61WElqw6
 yG+Ig7fZcrC6Gy2fNz07rh7I6r8f7nwSFrdJI3fUeRGYgw624BNpO5IgIDuxcJ4GsUPQLSK
 r/Zw/XLsgXAeyGstVrxoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ds4hU6aKOVY=:MBeJ/t/UBL7FUoyQfeEqxR
 diuTbilRiCWQFsy4t3AEtQxKbcCvQ/ixDdMWhha+bKUDBaSt0bAk4K20PbhTagiZRAig8yg+u
 kkwlDQga+VdvYe1FuflFiSy0JbE2Dh5MLDWFGccgy0mxto6nsJBs285FIUu0wV+5jFXs+6npn
 21Hja30o6l194n05/75s7n0I+WUdSIC+8EnyBzo38MlrDy8dRp0XAyR2YLAuG0I2WgYr3+C/c
 /4oG0yekRxLTlO3kFO+6H2WNQhv1bXG55LElv3EJya/WsR2eibdUeZb4irY2rGrXxsJifHdAV
 Uzzwgl5JYTx8eeTYBjN8gXLcv8FCLpnZVtppAPFihOUBd6KcZ6LusqUmSBalGSAelmuRE26VR
 Ss2qWXdmUYaevV9xKjeJu6uzCPPNzmBOKdxERSn1E2FExSgLSmLmqWtk2tPpdkvwYJChagueW
 oarez+v3V9yc5tjZZmzEs/jDrN1UV3Uo/jb01oG2ejuK/XQh6hCRuresH1lEPJenx9ImtsURr
 S781JVbk2WbITEYjx12hfTLb5QDwhX2g+c3Fe432xruokKWgfY3dZ2WtEljJ7YZgvon0heKTk
 1sgH9D33VvSxT2PCAWLjR1LA8QTKZjbGWbGWMuD6J277H4rBHLjtpK8iPu8GyrO8ilod8wc5z
 eG1DmHs5g5BSrEyCCr2Jyub1yxNBYi+P6NeTyGzkTOYp6T3qTLZ5CpSNsfKQrDmNtJeT8FxSf
 1q0nmume+etgw+ihkFcak52n5gfusAJmx69IbG2+IEOtII/+OO7QPvljFrhQwVGuf+nuff4HL
 S3nGJsS
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599179231098843389?=
X-GMAIL-MSGID: =?utf-8?q?1599179231098843389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Wii doesn't have built-in Ethernet and USB Ethernet adapters are in
a different menu. Disable CONFIG_ETHERNET to save some space in support
code for Ethernet drivers.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-367 (-367)
Function                                     old     new   delta
kernel_config_data                         13691   13324    -367
Total: Before=8341718, After=8341351, chg -0.00%

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/configs/wii_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 0b0f78823a1b..3167b9d7f3e5 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -49,6 +49,7 @@ CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
+# CONFIG_ETHERNET is not set
 CONFIG_B43=y
 CONFIG_B43_SDIO=y
 # CONFIG_B43_PHY_LP is not set
-- 
2.17.0
