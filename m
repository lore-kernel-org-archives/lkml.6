Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524861841; cv=none;
        d=google.com; s=arc-20160816;
        b=jIuoux8n8nb3PXJJPICbe9UIuhZDW9Ien/k3zBDIqBm9iBdvCeY2Bb9Q5ATU2owLAN
         2HRCYjn8UXR2giMQ8Mdd2Cb6O64N4iYVwTI3dARSl047wgYNuCfZNCtg30Rs9U6b+lcm
         4PZzBGW8/Ys7l4CpZmic5g/GaGSyyd+aT+kO0XjZP5q+2rp4slmzTBW4GKoiS7sMPDhu
         CZfcHHygFt45xTSXEC5cQbfHjIRdWBrjyc8sxGmzRlyWT3bHDDxJu/5jc13F8k8Kh7xr
         TPCMIbISPK0snjb/hd5d9jB3GvNOUsRxfNN8+q2UQvUbdmvOyCAiudSan54ItirsWdWA
         WNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=dZoE/Zmf2+dg9GmC5UiUgZUE2/Iyxt2AaquZl53nNG8=;
        b=UsjVmycFKq7qcaRLmEw9Lt1lSF0de9oRlcKC0Hla54JpOBz7MRN0OtWft8zUN3EUL2
         cy/bHEnON9JUK0q5mjTUBogVznb4uCTLRGRkkIcRTZsYl2djRWlcadH9hffHN7cifBgW
         dbN0auNA/8XuCoM/tTkuE0tQ9TIN+7iKNez7bfFWrjQvTbNLt5SgOxqiaNhAMDZ3WYIP
         gIc20SPpP5RYY7mDcKuQsrPiJXFZahK/7jdfBURIhn8EBRQgwaubQxtow1kKR2j7IZ0i
         ilz+1wfZqpMRxLT/nSOzybguKzwrwSFMFkQBS8wf0+4zxS30VjFMXl4cdF7s3yhdJGXP
         VdVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZrTCZY3RfjLg8F1QCzslML+XzbanzaVscfmdTvhXBoJJ5jEQW5y09dVTvkO0iR4fYYiyEEVDw==
Message-ID: <5ae38b90.82811c0a.c4c3d.cf85@mx.google.com>
Date: Fri, 27 Apr 2018 13:44:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.5-82-gd804f93aa2d9
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
Subject: Re: [PATCH 4.16 00/81] 4.16.6-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598908809599960279?=
X-GMAIL-MSGID: =?utf-8?q?1598933529849923735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 150 boots: 2 failed, 83 passed with 64 offline=
, 1 conflict (v4.16.5-82-gd804f93aa2d9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.5-82-gd804f93aa2d9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.5-82-gd804f93aa2d9/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.5-82-gd804f93aa2d9
Git Commit: d804f93aa2d92746fe97707a51352689786ee98a
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 79 unique boards, 24 SoC families, 17 builds out of 186

Boot Regressions Detected:

arm:

    bcm2835_defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: new failure (last pass: v4.16.5)

arm64:

    defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: new failure (last pass: v4.16.5)
        r8a7795-salvator-x:
            lab-baylibre: new failure (last pass: v4.16.5)

Boot Failures Detected:

arm:

    bcm2835_defconfig
        bcm2837-rpi-3-b: 1 failed lab

arm64:

    defconfig
        r8a7795-salvator-x: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        sun4i-a10-cubieboard: 1 offline lab
        sun7i-a20-bananapi: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        armada-xp-openblocks-ax3-4: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5250-arndale: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        exynos5800-peach-pi: 1 offline lab
        imx6dl-wandboard_dual: 1 offline lab
        imx6dl-wandboard_solo: 1 offline lab
        imx7s-warp: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        mt7623n-bananapi-bpi-r2: 1 offline lab
        omap3-beagle: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap4-panda: 1 offline lab
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        stih410-b2120: 1 offline lab
        sun4i-a10-cubieboard: 1 offline lab
        sun7i-a20-bananapi: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab
        zynq-zc702: 1 offline lab

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

    imx_v6_v7_defconfig:
        imx6dl-wandboard_dual: 1 offline lab
        imx6dl-wandboard_solo: 1 offline lab
        imx7s-warp: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    exynos_defconfig:
        exynos5250-arndale: 1 offline lab
        exynos5420-arndale-octa: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab
        exynos5800-peach-pi: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab
        omap3-beagle: 1 offline lab
        omap3-beagle-xm: 1 offline lab
        omap4-panda: 1 offline lab

    davinci_all_defconfig:
        da850-lcdk: 1 offline lab
        dm365evm,legacy: 1 offline lab

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxbb-p200: 1 offline lab
        meson-gxl-s905d-p230: 1 offline lab
        meson-gxl-s905x-khadas-vim: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab
        meson-gxl-s905x-p212: 1 offline lab
        mt7622-rfb1: 1 offline lab
        rk3399-firefly: 1 offline lab
        sun50i-a64-pine64-plus: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm64:

    defconfig:
        bcm2837-rpi-3-b:
            lab-mhart: PASS
            lab-baylibre: FAIL

---
For more info write to <info@kernelci.org>
