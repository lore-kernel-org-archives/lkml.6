Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524669851; cv=none;
        d=google.com; s=arc-20160816;
        b=z+S902ONgsBAwqn0iWWxbsh4XiLweaqwkZexkVyRxpb47pK6ZYGRfS9OYPunFN/SQW
         dinv/84sFyxgTr+7xcc1reCXtB0XDjbl4CDWZWTNw2S3ha7dgGvcC/ZA2LZTFhy+w+cy
         Sa7HWLD7rc26mzJI2cVvNtEuywvkKdueeeF74eBUJLMK6Uf2Y2yuB3xi/BawYsycLLoL
         EvKeIANPKv49Zarh6lGdUzlnFQTI753mNLiCHWAA55hkNJz6gNXiD8VUxmTzPEUdWruU
         as4mAXzt4rFODzDAlHWb3hv077VnW5KCMwF2BBzM42V+o1HZu4RGDr+vRysukpJ7jcf9
         +b1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=RVsn7WNuZJLKrPUcYfUW5Plyn3DaedFbHdqzQLVxgr0=;
        b=nhcVqHP/CqSlGYeR1KKtu/lBnk4QabTAYzIoUkGH046bs83wj+SXka2gNZdA60lC8B
         Wsp1WKAHbR72OrLLDlORxBleO33tkoZn6El8T3cBDGc9AuaSCb8GYsAGfqGfoSvst0/y
         INJIgkHd266ZEsnLPUJJo4XhKmKiyUwxx9lp8CFZcMFCD4cDi7GWllAyuD9lsL9xVlXl
         dB3yeeCqRm+GFEcN4EGnUUiYwYgWiVAYo0qmRa1YBMTSl5m2a2+bbNHx8VqmN0LdCCIX
         fp0GpJCVzPT5x6V2Zd5zDpFkfqXspgAf30+VrnLZmIQMfXOBWoEtAb2ZFIkuvZvrKBYg
         GjIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZrtEPBW2AofLNcMcnjAbUn4bHfIQx+WLOXrZ383N3uPh1bvS7OgtOsJyzifQxJ4KY2zBbHZQQ==
Message-ID: <5ae09d9a.1c69fb81.4e7d.142c@mx.google.com>
Date: Wed, 25 Apr 2018 08:24:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.36-184-g3cd53e436ee2
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/183] 4.14.37-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598714220036977205?=
X-GMAIL-MSGID: =?utf-8?q?1598732214872147206?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 155 boots: 4 failed, 133 passed with 16 offlin=
e, 2 conflicts (v4.14.36-184-g3cd53e436ee2)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.36-184-g3cd53e436ee2/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.36-184-g3cd53e436ee2/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.36-184-g3cd53e436ee2
Git Commit: 3cd53e436ee26a473b4055caa62e594ff14b7511
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 79 unique boards, 24 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        dra7-evm:
            lab-baylibre: new failure (last pass: v4.14.36)
        sun8i-a33-sinlinx-sina33:
            lab-free-electrons: new failure (last pass: v4.14.36)

    omap2plus_defconfig:
        dra7-evm:
            lab-baylibre: failing since 1 day (last pass: v4.14.26 - first =
fail: v4.14.36)

    sama5_defconfig:
        at91-sama5d4_xplained:
            lab-free-electrons: new failure (last pass: v4.14.36)

    sunxi_defconfig:
        sun8i-a83t-allwinner-h8homlet-v2:
            lab-free-electrons: new failure (last pass: v4.14.36)

arm64:

    defconfig:
        meson-gxl-s905x-khadas-vim:
            lab-baylibre: new failure (last pass: v4.14.26-140-g2a1700a4929=
f)

Boot Failures Detected:

arm:

    omap2plus_defconfig
        dra7-evm: 1 failed lab

    multi_v7_defconfig
        dra7-evm: 1 failed lab
        sun8i-a33-sinlinx-sina33: 1 failed lab

    sunxi_defconfig
        sun8i-a83t-allwinner-h8homlet-v2: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        meson8b-odroidc1: 1 offline lab
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab
        tegra20-iris-512: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

    davinci_all_defconfig:
        da850-lcdk: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab
        rk3399-firefly: 1 offline lab

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

arm:

    sama5_defconfig:
        at91-sama5d4_xplained:
            lab-free-electrons: FAIL
            lab-baylibre-seattle: PASS

arm64:

    defconfig:
        meson-gxl-s905x-khadas-vim:
            lab-baylibre-seattle: PASS
            lab-baylibre: FAIL

---
For more info write to <info@kernelci.org>
