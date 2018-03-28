Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522196484; cv=none;
        d=google.com; s=arc-20160816;
        b=THwMgn9rxG+aqTrUHAbxaz2isJnpnZbqHiDRqRwZhhkSvubYu3E1Nwz4GZ1eASLwF5
         12s19EFt53GZV3s5C/TGQdvdhpjSPSVP/jzQRXpgBCvdqECjdf6udpPHcAb3rL2baDN7
         yDn7uO01yOfoZFydlGINlYeNZyA+myHWPETUsVokfKf1inVxbIGQnbTkv/JmKRv6v9AU
         n/5W7Tt7eQo207cbJQ+/ceYFJ6G+2uVUU66DwfwLWCRgMk5bIrOClp3P8y5EEtu33plR
         SBSnWlDq3NrT4LZ2dBAc71jJsn45hicox/EbR60ky77VpyPwvdhZhruMJ24Bdz98xaMJ
         0/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=Xo6rB0qXCSopw3+o2Ni89WtJm/LYel3nRazL5bB/rf0=;
        b=rgWRXdUTwhyzxFx645uwr0tDityKHmI4BHbf8AZRCp6KYlRF2fBUh/ovJ0LuToAqN1
         gR4WH/oeg7PMSkyLe7yltShXT2o9hfWVvQvDi+Tecqeus/5ciqP0BZSd98vTct7cy6c/
         i6Oi6BGGz/PptaodoFDggzpaAz4SjxL9tStigRlBXbFPoes+4gqfCwG8v8iwMeFCIr0Y
         gO8OgblYLwdnXYjoZ64NA9DQOzU9R3H60IIzPDrb0UdK3t75HPlqPFX6SCFw9j4fzCjo
         X4+lQVZmgQA6YNa6JVw8uzmxLOAPZmw9FDAZzX8YiNNAe+Y+GbX7fe0jWKow7d7L77dN
         TbBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+gmrOIiTzOI2yM7oJ/W0UAWsPhhQJunT8hyFORfgTNZGjLWr/aPI7Jp80M4bfr7PY3ecwFag==
Message-ID: <5abae002.5b88df0a.be1c9.9695@mx.google.com>
Date: Tue, 27 Mar 2018 17:21:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.90-68-gf6c4b8eea9f0
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/67] 4.9.91-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596109117141919880?=
X-GMAIL-MSGID: =?utf-8?q?1596138700573618507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 118 boots: 0 failed, 106 passed with 10 offline=
, 2 untried/unknown (v4.9.90-68-gf6c4b8eea9f0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.90-68-gf6c4b8eea9f0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.90-68-gf6c4b8eea9f0/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.90-68-gf6c4b8eea9f0
Git Commit: f6c4b8eea9f0ff250efcd95723cd73b8f2ecfef6
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 61 unique boards, 22 SoC families, 19 builds out of 183

Offline Platforms:

arm:

    sunxi_defconfig:
        sun7i-a20-bananapi: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        sun7i-a20-cubietruck: 1 offline lab
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab
        tegra30-beaver: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-odroidc2: 1 offline lab

---
For more info write to <info@kernelci.org>
