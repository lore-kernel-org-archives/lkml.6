Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521813660; cv=none;
        d=google.com; s=arc-20160816;
        b=QVloyy+ENDM1e93aIrBiwnueiTvtLDdPJPycABh/MOoB/CI3Z005q30a6hhIsDGObd
         f4+L514BFGzJ0g96YopL0oNapF/QGqs72uhSseGSx+xxzBXAACJDcCOooT+EuY9NafPJ
         W/qYxkLvgNf5BDjIA73CvMtuCmrZPNRjhmYex5NK0qMpnASHvUd4mbH7E72D4YLvXJvv
         X3WcVogxIBEHFXGdKQx/DuKUqgHS3JgHqv+bpvt5sqJWUE13ZaFr3tc2u8YP0wRk/SEd
         MnrTfybVp9RUYU4NgTVQ6AGPHhoIUblrT0XrEfH1Gg1/M5mb/7wqjweav6oTMUORW6sG
         07/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=a42ECrAFKLW08aqGMzXzoMiyM0fRPbv4ujh/qn/bCXk=;
        b=b1Xl5D7pJjJqqFHb60Rs06/fEmbM6Zu27+iVBAVEwiJVUTveuPuz3bSM+21fx+ldJU
         nyTjoE9X8C0hkWo5KOkSIY9quv904doo5+V8t3ercQzf6eSHS5fTDUpK/982NTEZURmJ
         3/1YH4prlG7LDKlMXpDa5y9thFxj9raAoTht72pte5hxi8WkDgWZXGza6aK5HDU4Y54q
         NifFUy02h9ya0CGZzEseL5lFp07PF4Ej2MmtpjpYGP5JmUrbVl6+jF+Hslk2bvT0genU
         vqaYzWre3u/N+AOUFDrkwMrHOWPXVIi3e+jfdh/T6nxXdnmDZyBB1gSS7gUso7sg1y7q
         3prg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx49PuBTNaXrZugE9HwatQsfaZbPaMttEhWoqjMfpM0iU5221Ro4/7kq0w6TPLdQsc3nvWgtsoA==
Message-ID: <5ab5089b.4f9adf0a.ac3cd.af0e@mx.google.com>
Date: Fri, 23 Mar 2018 07:00:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.101-47-g75905987faeb
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/47] 3.18.102-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595723242372704468?=
X-GMAIL-MSGID: =?utf-8?q?1595737281500489489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 60 boots: 1 failed, 55 passed with 4 offline (=
v3.18.101-47-g75905987faeb)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.101-47-g75905987faeb/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.101-47-g75905987faeb/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.101-47-g75905987faeb
Git Commit: 75905987faeb412049f61f2f6500feec0e2db055
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 31 unique boards, 13 SoC families, 14 builds out of 169

Boot Regressions Detected:

arm:

    exynos_defconfig:
        exynos5420-arndale-octa:
            lab-baylibre-seattle: failing since 16 days (last pass: v3.18.9=
6-14-g9fdaa6623e85 - first fail: v3.18.98)

Boot Failure Detected:

arm:

    exynos_defconfig
        exynos5420-arndale-octa: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        tegra20-iris-512: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

---
For more info write to <info@kernelci.org>
