Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518204985; cv=none;
        d=google.com; s=arc-20160816;
        b=LYRTIRZA+06C8omXboF9svZxPcvFyw6bhrhx4j0Iviy6a5RSh6b17atWJcnPobXmus
         qFnp/SSBj20bl4sz6r+0QmKrObIKexQbY3w5EKdYLQRuS55JZ676jZs++Ru4pY5EHcf7
         cbn5bOBcxiTMbXtF0Y8r3UNeBaKfbRIFMueB8GsRTccxotHoHAiEMCzP3FINDAhZt3tX
         +SLzd0pdjEvuL3SOT9A5DBswJyVtyvyTxOEGMh8Y4tucVCmJVsS2karDbkmAkNoBcLfP
         VkIrw1R6I2kqsSmLnCr21NB5l1xGqOlr7+xzvCZ16A1aGJyldqnwOQEOdQVCDT2z0Qn0
         bKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=CY0FBdx5nHsvmL5Lurxi6WSlgu77NvUUCOZVQEZxG8g=;
        b=W9TPLDnmfPkRna4en9g9vATNglGKkvk9BNQSBDA52bgGxRXLwsrFrK1eDWLMbXkour
         rqY3luIVgrdRe2sclBj/t8ORPSc2bKSUIydatz3+uDDDuTwyxDA8TwKM/N14+r85iOIl
         gayFCbHg5nvxFiTG892dqBCIU2npHkqYn6Jtmv4s30UpPSbRxKNcVFbrWrkGAwmrUdja
         RHoVb16ZMZZoHpYqIQimOearWF/oW4gW1Unih8SxvYz0jlppSqpdSfBoBoTlBtiAkdYR
         dO14xJnCTdOzSPDKiAJzC2g0WTLo6bEXjdTsJOJSMcgTpIlJkXfLY4uxcNghdHbO57Fn
         i8uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x224k7DOq/PQALLo1GzRW4b+IY0z98A8nwjpusBT/rh9EhvKKmYSe2s7zCzODWU0CKsNY9M+Uow==
Message-ID: <5a7df838.2696df0a.9695f.475e@mx.google.com>
Date: Fri, 09 Feb 2018 11:36:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.14.18-23-g8d861f5b27b0
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/22] 4.14.19-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931271366574701?=
X-GMAIL-MSGID: =?utf-8?q?1591953311522028166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 111 boots: 2 failed, 109 passed (v4.14.18-23-g=
8d861f5b27b0)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.18-23-g8d861f5b27b0/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.18-23-g8d861f5b27b0/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.18-23-g8d861f5b27b0
Git Commit: 8d861f5b27b05466ce2a9d3c4108367555dccefe
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 63 unique boards, 22 SoC families, 16 builds out of 185

Boot Regressions Detected:

arm64:

    defconfig:
        bcm2837-rpi-3-b:
            lab-baylibre: new failure (last pass: v4.14.18-19-g44b8fc264b98)
        r8a7795-salvator-x:
            lab-baylibre: new failure (last pass: v4.14.18-19-g44b8fc264b98)

Boot Failures Detected:

arm64:

    defconfig
        bcm2837-rpi-3-b: 1 failed lab
        r8a7795-salvator-x: 1 failed lab

---
For more info write to <info@kernelci.org>
