Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521242407; cv=none;
        d=google.com; s=arc-20160816;
        b=HQHEvFDgReiBb03po0ueUWr8noZn3deE9IFb5ovKU5Lhz5tKOSg9672n74lbCbgF7Q
         dtpUe7ojTvKJY0zNWKeOAWJs/MKI8Tz7uUyIxOIbWLiEwgQIRZHqrEItndpBcnhiKZ1q
         heG5BdEuKCoFiFlIAKHFo0jB4L8BpiklJSQjRhdsSVP4xHV86+H8IpR2GLGQEHjeJQnq
         2xaoiCilNRaiQAwkb3+WWTcxnXlZ3ZDIzYkCNK6oNO83vLSnzj3ikCF7fX8/7WfGrnP4
         WcGdfDq/jW8cw2T3ipeIU++5+4qVgioh0qeqebSkRp9G3T0L7HB3jQaxT7i6gyXwwfbr
         yZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=LJgPWccRxIHXgPcgrq9O3mDqKiFsRaNy3/sZzTeZoVo=;
        b=kAtr1a73i68ktK584kzn2NeFWVFPc68eysyt5MLfshluJ2zcQx49ufx+8+K8sCWKhq
         xKBh5NVPzbU7xBRZK21GRVY2Z9Vo+nznCs7bo6fbhcm+5/XTYCu18Chs1Ya2Z6U50i6c
         9ZzUnuRK6WHDMxvfQ1LrKKG8KG883lJ9XQr+lHlqQa7GZ4by1y4A+95Mw+TnY+yV1Uq5
         S1dLBH5tLDN9Fg8ZUt3kV1+wSXoify3ZBXTXsqczS9+YTzgk+xNilxlUvQ1XfL/2pwPv
         PwbHSfFmAmqk5faHHDJ3RBmM0KDgQB/WtjIgdF3rpb/G16lYBPBif0vOlryI0Gzno4na
         I7Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELsVOrXSd98Crq3BCPFMop1lvUiCMHlVF4m5na3imNFph5w8uOkIlWi8l9X/5U/PqOfu4ox8lA==
Message-ID: <5aac5126.89c5df0a.9807c.7028@mx.google.com>
Date: Fri, 16 Mar 2018 16:20:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.87-87-gc854dd85ec72
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/86] 4.9.88-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595108715713522943?=
X-GMAIL-MSGID: =?utf-8?q?1595138278818011388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 115 boots: 1 failed, 92 passed with 20 offline,=
 2 untried/unknown (v4.9.87-87-gc854dd85ec72)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.87-87-gc854dd85ec72/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.87-87-gc854dd85ec72/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.87-87-gc854dd85ec72
Git Commit: c854dd85ec7201a4fef08919c0ea66f96d81c1a3
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 62 unique boards, 21 SoC families, 19 builds out of 183

Boot Regressions Detected:

arm64:

    defconfig:
        meson-gxbb-p200:
            lab-baylibre-seattle: failing since 4 days (last pass: v4.9.86 =
- first fail: v4.9.87)

Boot Failure Detected:

arm64:

    defconfig
        meson-gxbb-p200: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra124-jetson-tk1: 1 offline lab

    multi_v7_defconfig:
        alpine-db: 1 offline lab
        am335x-boneblack: 1 offline lab
        at91-sama5d4_xplained: 1 offline lab
        exynos5410-odroidxu: 1 offline lab
        meson8b-odroidc1: 1 offline lab
        socfpga_cyclone5_de0_sockit: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        tegra124-jetson-tk1: 1 offline lab
        vf610-colibri-eval-v3: 1 offline lab

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

    socfpga_defconfig:
        socfpga_cyclone5_de0_sockit: 1 offline lab

    imx_v6_v7_defconfig:
        vf610-colibri-eval-v3: 1 offline lab

    sama5_defconfig:
        at91-sama5d4_xplained: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    bcm2835_defconfig:
        bcm2835-rpi-b: 1 offline lab

    omap2plus_defconfig:
        am335x-boneblack: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab
        juno-r2: 1 offline lab
        meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
