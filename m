Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522191683; cv=none;
        d=google.com; s=arc-20160816;
        b=I8IsfY0wE3UQKB3YLFjo6/TK+kWqrQiGzmkX26477JF2ElK6muPwSOk8s4M3K6HehW
         XVKxV4TVszu5MP7Z7LuNEUmqbJGV2rWwzfETHtYiUV8kos1N0MBTX5sGYF3y+NCRGBvj
         bW/aIMlta+L8J1Sk0ftKt7CiDpvA1qVXpAg3YB+Cxm/8/ob1zfVeE3rQ5NItMBdNFET5
         5OQknWNrnLqrWCWbJ7ow0VPV+ghFz5qf0xGFr1AdcaX6VozUJY5dKurtSW/6Ul1dl0Yh
         pymJ9p/NXBiMAKTfJSYAzFDswJ3pW8/AFifRLSSoj8y13w+VcASFnsiqgk1FGvX5iN67
         FkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=4C8aSi6XNo1fVxHFxlJCFSkzmqobD/eVzsnFEMQzHd4=;
        b=AjPXnrHFIdDxEnVdZQYRl/y38D5QJa8Q/Jjth+y1U4exUbBL33hnn8NjgHv5vNEVO0
         YScfmP8ESqxANu+QbXWS5Q+SsgzvXI6B/9nY3Tgymh4j3DjvbPazVZjjp2s4NSnfP62U
         ht13CD0P4pEkx0ENz9PhvZ1lNHfQc7y12uxfjPsqjMPxA2BHeOoAeQ9q6+k0GWg7JmiG
         kGuIY4oj28Au3YvHAsCCkZkgjI0e5CTVPJcZDgsAF4IEQx8mEYoQ/VV3HVji3ozjF8Jc
         M2esEhl23abI1wAe/DS2W+gJhUQMsnCyjOeGA7dD/iYE+LvmulBLBuFOPkpeI3Unxcns
         wb/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx49fgRW2uUVGdOl2zvI60VSWl6Bk55YL+mzvWFksHSsX7tq6en7mystwTJNm81qHX3udVPJmRQ==
Message-ID: <5abacd42.f4a0df0a.b4d43.1971@mx.google.com>
Date: Tue, 27 Mar 2018 16:01:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.15.13-106-g720c68fc1406
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
Subject: Re: [PATCH 4.15 000/105] 4.15.14-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596109687126201688?=
X-GMAIL-MSGID: =?utf-8?q?1596133666850083764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.15.y boot: 126 boots: 0 failed, 102 passed with 20 offlin=
e, 3 untried/unknown, 1 conflict (v4.15.13-106-g720c68fc1406)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.15.y/kernel/v4.15.13-106-g720c68fc1406/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.15.=
y/kernel/v4.15.13-106-g720c68fc1406/

Tree: stable-rc
Branch: linux-4.15.y
Git Describe: v4.15.13-106-g720c68fc1406
Git Commit: 720c68fc1406bd0e2002497770ff739bd21e5dca
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 68 unique boards, 23 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-baylibre-seattle: new failure (last pass: v4.15.13)

Offline Platforms:

arm:

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        mt7622-rfb1: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    exynos_defconfig:
        exynos5800-peach-pi:
            lab-collabora: PASS
            lab-baylibre-seattle: FAIL

---
For more info write to <info@kernelci.org>
