Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523035329; cv=none;
        d=google.com; s=arc-20160816;
        b=Q6/9DLiaAAajVCAH8GV869N6HxUva+W5GAtSUrScBWu6tC5WsVhxJPIUIuffp1K9tm
         4dVFabI4VO74YNRYHPlVo7HO5Lv4ZrF/PLZJ8l8xNXgjw/Pr8G0HBtBsoiM3SwNJOzae
         Ug2/lu4FWw+RC0BJ4EMO+qjP/j3zmOymct3MG2L1ItPrR7XhhCD1Vj+2RL9cP/9T6TJH
         ellNrESPzKlacX8jmaJnlaFZYEtTLXSF1Ek5jDB67XLJBy5ZxsbS3jpViZQ+rOiaOXBy
         E1oZA8Ts54+SU5jLL2rBDuP+0tqf62O3OOS6ciPi2/9qDl/xviuXfEcTEF1rMcEAzXgu
         JRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=JGRNEIlB77EyDGaflVGabjIITyfNYmYJ9SWsmztjSvg=;
        b=HoCW8gAjvHZhcMR+TuOX2A6PaD/EnH/1rIWsGNjNnv9hRzFUpe4t4K5En1CUxsc0O7
         f+U9aZ/Hb5ygXmGaY2+FQM57bffXzfmem1npwqLF+Dx3avJah0CGSna9Klx5YPVH8dzZ
         JFA8DI1u7Jh4Us0Fd5SXzmMVjggsIO0j2Vmgs/8Dz8BRksqAm/oUSEMzZSUdzKXb9C/a
         y2yuBlu2ANc/v50hI7ycU2iQurUWVu5uwc78mVl0WvlCHTmxu3+9WHNb7Bh8DY4o+y0i
         LvfHOKCinoC0uklli15w4dWaPc1Fcd6vuxcs8mGHmEgNnXsCJ8IKsQERv+RRHvGFnYmR
         /ysA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4/VpQU4Xcc1jh9UHLRKhEEFIKIbYCRtn/EjZQFxrAFw1ubjZN4kA1j3opURv6vRE75Rnq1Edg==
Message-ID: <5ac7acc0.6ca0df0a.2b35f.23e2@mx.google.com>
Date: Fri, 06 Apr 2018 10:22:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.126-73-g82bd29002c67
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/72] 4.4.127-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597003647223423394?=
X-GMAIL-MSGID: =?utf-8?q?1597018293740452724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 49 boots: 0 failed, 47 passed with 2 untried/un=
known (v4.4.126-73-g82bd29002c67)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.126-73-g82bd29002c67/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.126-73-g82bd29002c67/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.126-73-g82bd29002c67
Git Commit: 82bd29002c6763e5558015c877c50373d1a14560
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 24 unique boards, 12 SoC families, 13 builds out of 178

---
For more info write to <info@kernelci.org>
