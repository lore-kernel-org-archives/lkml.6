Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525137858; cv=none;
        d=google.com; s=arc-20160816;
        b=MrlCMVRFGKVruwIfxHmmQmFl7jL9z/OgYbR7XmjR+wKYmxkbOx+V7xokD+ay3pMJuK
         bIop6rEToMJfXiSH3pJyzDP6dEV78SyhX8xo9CvsURcsFN7iPDt2mwnMtWeUd92+OJjY
         4cLDrK4W5onZ5D3gA4LgeV07q1S7l02pRKPDqWLv9etZaU6kLAP6E9w4aZQAT48kgOYi
         iBkM4CkXTx7nYaS2Wfy+eno5tyTv6tRCQtqJ/mWYdMlIOrA5w/fdAs0X9Y7UDHuAtcGz
         HGfNEtzgYZdw5Uue/tJ0tBXDwx4UvBYY5hGlH0YbIx+kA6aWqBVNlj6dN8qyn52mBqqI
         1tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=UPE4LRuWbFqLuNYlxsC/JUAzijFFHN2o89XmNwF5ejU=;
        b=Io/lDRPJWjGeFLtt1OybS2bh2hYk2p12QzPGwWTK96J1OLwacc+f6u/qcaYaQWTpjz
         9Ro8RxqhtQYm4/Xq1EkMoee/NQF8E8ZjaUpnwKemI7MDo3ektfvflJsFRiLsmcQpLdzR
         AdTp0ZiWqSRg8d7Lv+FKgVJLvPUC1LxnXwnxckTtHRw4ilaWAAwN14nEWKrf+5Galy6Q
         PyJRk+jimqhzy4a05rzAhi3HMRpWTZu1EPCw5QPzJBWuSYUAoUxs0b2QrROOEBPWDQ99
         W+8mZyRoYKOmwaY0uz2DOE4ZlOTLG2sxfh2WnvzDIjZuRmo4asLgt8vrLXzSzkheZEbf
         tmXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZqeEHcrGLYLWWn2h/VIeQvL+HCvIok7YujSMIQ6Bzj9b7xgogg7p9+/dmI2+UYTOSujQcf7tg==
Message-ID: <5ae7c1c1.8cd51c0a.fbc7d.53b6@mx.google.com>
Date: Mon, 30 Apr 2018 18:24:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.38-92-gee90ac924864
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/91] 4.14.39-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599200485951851677?=
X-GMAIL-MSGID: =?utf-8?q?1599222955314830630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 144 boots: 2 failed, 134 passed with 5 offline=
, 1 untried/unknown, 2 conflicts (v4.14.38-92-gee90ac924864)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.38-92-gee90ac924864/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.38-92-gee90ac924864/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.38-92-gee90ac924864
Git Commit: ee90ac9248644db2ff37da8407d08e751813d532
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 77 unique boards, 23 SoC families, 17 builds out of 185

Boot Regressions Detected:

arm:

    at91_dt_defconfig:
        at91sam9x35ek:
            lab-free-electrons: new failure (last pass: v4.14.38)

    multi_v7_defconfig:
        at91-sama5d4_xplained:
            lab-free-electrons: new failure (last pass: v4.14.38)
        sun8i-a83t-allwinner-h8homlet-v2:
            lab-free-electrons: new failure (last pass: v4.14.38)

x86:

    x86_64_defconfig:
        qemu:
            lab-collabora: new failure (last pass: v4.14.38)

Boot Failures Detected:

arm:

    at91_dt_defconfig
        at91sam9x35ek: 1 failed lab

    multi_v7_defconfig
        sun8i-a83t-allwinner-h8homlet-v2: 1 failed lab

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

    multi_v7_defconfig:
        at91-sama5d4_xplained:
            lab-free-electrons: FAIL
            lab-baylibre-seattle: PASS

x86:

    x86_64_defconfig:
        qemu:
            lab-collabora: FAIL
            lab-linaro-lkft: PASS
            lab-mhart: PASS

---
For more info write to <info@kernelci.org>
