Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525142660; cv=none;
        d=google.com; s=arc-20160816;
        b=lgr2qfw+Bl3JtnHxjDAWLATgCE/QyNO1dugBom9mQ0EOX8wNGHCQP3INQdHqXgNBR8
         3VoDqh9gvXHSBpL6edr6sIMFT22eaRhU+UsSzfnHSZl1nuNZMt6DrB5IPh3oIwsCYhCo
         34pGwLNWc51a0at5kQSJalRV9CEiNTXOB/fgcADIPr1HQwCJc0URDuDEoDZvAaLN/Ftc
         /XOtr0ON6FBLcEVwlMESSx5Xa5GlP0uRGbheMlXPD96Wop2UdfBPEouafSsjdoXRhXS1
         XNWaE1qMBroIlJVM9CmLSmXBrrCXpV50ac0W8u3nTzJEfedUj+2jGZC6kDhmy8p3iAM2
         LUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=5nuB5O149yk3kjqNijr1z6lRAvHm5fy7hTpgkFdHhsM=;
        b=YkuTt2uykwT0zSPGRrPefeUMz1g3u6l9p/F+H2tfSqivFPHUIUHRo+Z8T0zxXPejCg
         it3B96WjFhnnwE+FXeCeZ0e1bwAh1oAf7Ve7z3xgubiqxKrqkFoVNBdjTDU9g7EfKjnO
         wL/5Xf4kzxSSLdUYKzMv5ficzhuGOsvzvt/kCjVDGMvqppYLF787VGKIKIyIZbg49EEm
         GE8pf9yXdok12sshoKLAPsN5VEde7Ri6SeYLXUCpHjr8QoTS952xNEZ2I8Y3h0Gr5pkZ
         jCim/pZD95G0kF+LVLq2adf9+UGevhd9QbgiFkw0ESzaqsweBGgpFOMH0EZ/gdNH1mhv
         kiKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZobO5T700aWMHNc9CCNrmGUCIVx+aRrq5cw636NAKdFvbatmoWj+EWvIDK3wFiKvhq1FCt6Tg==
Message-ID: <5ae7d483.d3371c0a.50d58.d1dd@mx.google.com>
Date: Mon, 30 Apr 2018 19:44:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.97-62-gdfbcc7b09b85
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/61] 4.9.98-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599200428921963582?=
X-GMAIL-MSGID: =?utf-8?q?1599227990424239370?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 137 boots: 2 failed, 129 passed with 5 offline,=
 1 conflict (v4.9.97-62-gdfbcc7b09b85)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.97-62-gdfbcc7b09b85/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.97-62-gdfbcc7b09b85/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.97-62-gdfbcc7b09b85
Git Commit: dfbcc7b09b85cb3ef0a6253f94c245e6ddbf3a80
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 69 unique boards, 21 SoC families, 19 builds out of 183

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        armada-375-db:
            lab-free-electrons: new failure (last pass: v4.9.97)
        armada-388-clearfog:
            lab-free-electrons: new failure (last pass: v4.9.97)
        exynos5422-odroidxu3:
            lab-collabora: new failure (last pass: v4.9.97)

Boot Failures Detected:

arm:

    multi_v7_defconfig
        armada-375-db: 1 failed lab
        armada-388-clearfog: 1 failed lab

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

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    multi_v7_defconfig:
        exynos5422-odroidxu3:
            lab-collabora: FAIL
            lab-baylibre-seattle: PASS

---
For more info write to <info@kernelci.org>
