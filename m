Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AG47ELsSkEXCYXzI6+VrDXCz+ZXXBf6Atw91nMpL/QXXzT/KAXksEblmDnIi087Mlh9du2MZR3Is
ARC-Seal: i=1; a=rsa-sha256; t=1520552469; cv=none;
        d=google.com; s=arc-20160816;
        b=ICAwS/lHLH36U+CGyeCggyewa+j0mE+33No+H/kjo5+pCm7V/SYrjo/Q7Xi6cqqKa/
         Qj14ty6h8RcU3RIkg5rzLO30X8THsgFUv3RfRtHM5MjnnY+kVs+vUJdgAjzqJUoml5HQ
         VxZKwAptjDlBPJry0TAzZTXmpapWCImhyj6l3ew+PPs+2kVnVxHvIuV9sAfPe5c3IEol
         bFX0LfZ0snX5Nu1PvbSF/JbApw37iyRgTJJm3XPG8aBZu/RmT29Sguo0Zt8787rivB+O
         iBnR6rQSRSe5+UHJh/FVlCvGr69fbpTGjJpBa9+NM41iSrz7KQyWh3oAnXZOvi6pgUH+
         aL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=QkYjDia3Bzf8XnZ9JW0o1HhFU1uGYnDOW6lNVMhh3TE=;
        b=VEvCSnMXRcXJ4W5fepxyv0mjLjwiswvKwFgVkPs90ExHg209jqUHq0yfFHFZrUDIqM
         BqH81Ay9NaTCdaV3NHGFwr91oWOMmiup1qRFA0VHxFacOnrPzfep5kZBTaAJy4btmN6O
         Cx1KsBS8Sq2Afwae/Q7CM67t9GieUG2sfFluUVOMmXs1xszniOV4Bayv8BF9y4JeUoil
         uHCt2DpL8ZdpNhhENZuB9o6HV4lql2ulshJSmPQGhyURqE8nABIrubGEFRVQ81c/sHly
         Bz5wyp1kvtaCM2lHXmTT4gB2QDNhD92eiJqTnB8gIwtpTnNR9OdTfizsWW/UhiB+8Cno
         7P5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.20 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.20 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/8] MAINTAINERS: GPIO: Add Documentation/driver-api/gpio/
Date: Fri,  9 Mar 2018 00:40:17 +0100
Message-Id: <20180308234024.24145-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180308234024.24145-1-j.neuschaefer@gmx.net>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Ogh2i7vV+Zkm1enYb+V5gERBV10RaCyzAq29AKm20O+quXsBD/P
 7wa8LVxhMzlL+tO9jkzGOeBF+vFJDCFywP+GOAtnJt2DCmINntuGenUFbr7dxF8guuNsE7B
 I5SRwB04ydOQxABqHk9nePd4dIUIpcylTkUg05otcm7cUor3WUZVc8zrg8FBNujm5lBB1kG
 xzoBvZGvFnPlfR09raHkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2hSDu3wEgrY=:StJKNtAli/2KcQ5tIcHyYM
 MJ4cQsWt64aRlweYqOxa6YRtwM9BAdkMpvGu8gdowAGc79j1cWExxaOo5+hcEjP+mKZt8Aogk
 4s3kjPCcirX4dsq/ewN8uzT+1g9nRgmlf08g0JeOcU5zC80t/Yu3htF/AibO20Rq0xuvJqbuQ
 mX3pIsSaMcZMWcMcf/h2842UCe1rc9GuvMp0x/X5pgo4xXJUh7HrhvER6tHKdF/6afcB/sukZ
 lBAZoy2yH2pYW8jZPMHSB91ujLeDBrBA3/ac0/nMgh5gRdhcaFPyhQaIfYPfcFnuofMU4pQa9
 zm9GUXAtoPZy/HbD9pn3nh5JWULOKa0iDjn+j+I2a1KmHKfcApKTp/byQXe3Ak3umKWf3lzT6
 HM/JKtoFmrd7h1QX4cMkQFM02Fgviy1BC9O2wtfu1YoYWrYIZ+VL9SnjEuFP5XI+pA169pcNf
 TfprYUtnMKrWiecnb52K1MdEBHj/CoWpUxiK6J635otAppPm7Nu7xMlpunByt9w3bZqbP6inY
 OsgeGCXcrKoFrLuI4PQAmjD8aKLRRTDTol1ZJx8Ht0uw6J9Xte4Dj1k5SPSXojJ0eQRgFq4mo
 XWxXmisUXlPK2z/YoKDonFpw6B/M5A4mDYGSe3QFk6mM2086J9+zzfTC3oiB1rzaxcf8/dh1A
 QHWYSxX+p5XiTl9YuibVEN3Z6QbSD5pr09TjBFnq/9wxBzRzNJbrKj0mxnkGPqU7RZNGaticT
 YWRG2VEBVPEH+gg4g4T7e2BE57tOV4SKwBgoZvU6j9gsmi14/NR4RCNc3BugC18JfJOL4mmYn
 /gbNoQtFmcc1RD+RyRgvXzh0G8mj/ABrJYkzULJEGahAvPUkVQ=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594414826109908083?=
X-GMAIL-MSGID: =?utf-8?q?1594414826109908083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Steer patches to Documentation/driver-api/gpio/ into the right
direction.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6a89d31e4a4..313c0907020c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6029,6 +6029,7 @@ L:	linux-gpio@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/
+F:	Documentation/driver-api/gpio/
 F:	Documentation/gpio/
 F:	Documentation/ABI/testing/gpio-cdev
 F:	Documentation/ABI/obsolete/sysfs-gpio
-- 
2.16.1
