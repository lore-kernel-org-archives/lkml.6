Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524488617; cv=none;
        d=google.com; s=arc-20160816;
        b=PUhbC1DvvaYIvcdZxPMRd62IXGRXLk1Xgv8IfAizVCkXl09/xZF2xVqWQ2yLPVQnx/
         Q6UQOcrvw5Y4AyoqI1ZoaCz9uiZIm4MJkxgpZ3jTIca70/WKyly2s+XZq/HimnoVyQlz
         8bYfe6Mcsc12GRwRSPAF43fu/fTYeJE3dlUoDpzwDh3hMjVnNvjWCt1fufpR4lpsKSN7
         7p2vd23mL8OY+jsUh1+afEYSUkWufcRBefsW7H1px/7ZjQjzr7y/xHn9R7cRWmEIUyHB
         32nhcN47safQiFpyqFPQca4txiOHBgURsszOK14agrRgx28PsroWc6w7vgFeyIiL+1t9
         iqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=0e4nImk3qTvDTnhNRZ3LZbNsG6Z6QncECOLOkmfcjsc=;
        b=tAa8D6a3j8TLGVzgTenUKMZ/PhuBMdMoGwHNPiCkGwCMu8LYGdqDT4dvG2yOdkuN6c
         vhpPYVO4ZiAs9SrrTf1zdbuj6EV6TX9kInXiq9JnBdTKta4FOPneyK1vlWVLkBZLII2u
         iTVRTao8OGTJ3DN9HSEYCLm4OxikWBaEKmDMLJ0rKdbhVNIEwOjNB2ZIWj+8nUjXCfkH
         9+42f/wZETFHd7ITt6ssBU6erb+yAPV57DwJpgjCJyAocDf6rFw8VPllOQd2sULCQp39
         jL397maz9fwHSFwKgHTMQBQGL1xPZvyMZKCqkLYnKO4dfeJ3yD5Qq6eCbEUKWTT3DEjH
         UhXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+sMU64Hs5o1oGa/0/BZzWM5LqT0f/kvQKGqkLE9uVKRraa6PLQ+2QOvbhT1RNG6iGZ9ezUKQ==
Message-ID: <5addd9a7.4b141c0a.bee12.5a38@mx.google.com>
Date: Mon, 23 Apr 2018 06:03:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.35-165-g7474ba098676
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/164] 4.14.36-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598455435628222896?=
X-GMAIL-MSGID: =?utf-8?q?1598542176122406260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 152 boots: 2 failed, 138 passed with 9 offline=
, 2 untried/unknown, 1 conflict (v4.14.35-165-g7474ba098676)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.35-165-g7474ba098676/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.35-165-g7474ba098676/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.35-165-g7474ba098676
Git Commit: 7474ba098676c3c439800ead8f99f13517e6797b
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 78 unique boards, 23 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    multi_v5_defconfig:
        at91sam9x35ek:
            lab-free-electrons: new failure (last pass: v4.14.34-215-g6c533=
3913b2c)

    sama5_defconfig:
        sama5d36ek:
            lab-free-electrons: new failure (last pass: v4.14.34-215-g6c533=
3913b2c)

arm64:

    defconfig:
        r8a7796-m3ulcb:
            lab-baylibre: new failure (last pass: v4.14.34-215-g6c5333913b2=
c)

Boot Failures Detected:

arm:

    sama5_defconfig
        sama5d36ek: 1 failed lab

    multi_v5_defconfig
        at91sam9x35ek: 1 failed lab

Offline Platforms:

arm:

    sunxi_defconfig:
        sun5i-r8-chip: 1 offline lab

    multi_v7_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab
        sun5i-r8-chip: 1 offline lab
        tegra20-iris-512: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm64:

    defconfig:
        r8a7796-m3ulcb:
            lab-collabora: PASS
            lab-baylibre: FAIL

---
For more info write to <info@kernelci.org>
