Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525791902; cv=none;
        d=google.com; s=arc-20160816;
        b=YR4FQ9DoaRPl6e52pGiVB1QtRxpo9ohzzopMtpx+Y+KZgcG3zsJi7jCneyIZMmkTP6
         uRRud0lz34ptX82hUmeUhgDyY1rttdyh9v6Zgy4+JfsOEQIFkruTO4APnuY3R9TaP1T0
         SeWGiiz9aF4KPeVHEXCw2DCB2vksZYn0SNBLb0WRU5JlvnlMQTexUG+e/e7eo5wUpnq8
         KM/Mu3RMuhPOPeV/H6UmPP9tI503hAkZCPrOgptevWKzD4R3XbSiiumd5WxcHiEiO24x
         1E19rOpPUHNf6ZKyrkYF5qiYgQDDmh0XDe4XmIUcgYeMXnGCCuk9Y17tGIc2uLQdX6ob
         we+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=VesxlB7Vbt0s6Xq0XKB8pjGL68nw1ids869A/aHXhXA=;
        b=YYWdaAaoWiWIPDzycUkMSeVfU3dB4Wij6p22tNQB4gF6OitF+v1T52akUTxo0dWOUf
         TiQwGe3L3r60vZXMDV6JjUrjNjLbZnPDpaIcRMpfafpcD7PM+s52q55h7jdU0Cj4qZru
         hrAK48ZNJQr3DlVrWZ3L4lSOAsZllJe/zvWODDLOdO2azV+NaHgBYHk4f7LRcSu3+7Eg
         6kgu6guGv5Nm19WDAbMo0PjsNNNRy2FMTPaQFJZgvCRU31bAakLWRvzbr69i3XuOPGm9
         alnadGJ7okBs5YDtIMzgD1Hot7grE3SHnQY+Lt5OHbe47n5679+8YC6UiZv8TalLCohk
         koqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZq+Im8s4Uwl8c1hVUE/HRGyY0LP9a9S/13VMXlFFnzQ5D3YjEKztIG8JXfxMzRb7iZN/sk+bQ==
Message-ID: <5af1bc9d.1c69fb81.4944e.b595@mx.google.com>
Date: Tue, 08 May 2018 08:05:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.39-44-gc5a9c8283a69
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/43] 4.14.40-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599882950858871392?=
X-GMAIL-MSGID: =?utf-8?q?1599908770116386070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 114 boots: 2 failed, 104 passed with 5 offline=
, 3 conflicts (v4.14.39-44-gc5a9c8283a69)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.39-44-gc5a9c8283a69/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.39-44-gc5a9c8283a69/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.39-44-gc5a9c8283a69
Git Commit: c5a9c8283a6928d22ddc589157213f4f331fca76
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 56 unique boards, 23 SoC families, 15 builds out of 185

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        am335x-boneblack:
            lab-collabora: new failure (last pass: v4.14.39-4-g5ce1e4d96025)

    tegra_defconfig:
        tegra124-jetson-tk1:
            lab-mhart: new failure (last pass: v4.14.39-4-g5ce1e4d96025)

arm64:

    defconfig:
        apq8016-sbc:
            lab-mhart: new failure (last pass: v4.14.39-4-g5ce1e4d96025)
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: failing since 12 days (last pass: v4.14.26-140-g2=
a1700a4929f - first fail: v4.14.36-184-g3cd53e436ee2)

x86:

    x86_64_defconfig:
        x86-atom330:
            lab-mhart: new failure (last pass: v4.14.39-4-g5ce1e4d96025)

Boot Failures Detected:

arm64:

    defconfig
        apq8016-sbc: 1 failed lab

x86:

    x86_64_defconfig
        x86-atom330: 1 failed lab

Offline Platforms:

arm:

    multi_v7_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

arm:

    tegra_defconfig:
        tegra124-jetson-tk1:
            lab-collabora: PASS
            lab-mhart: FAIL
            lab-baylibre-seattle: PASS

    multi_v7_defconfig:
        am335x-boneblack:
            lab-collabora: FAIL
            lab-baylibre-seattle: PASS

arm64:

    defconfig:
        meson-gxl-s905x-khadas-vim:
            lab-baylibre-seattle: PASS
            lab-baylibre: FAIL

---
For more info write to <info@kernelci.org>
