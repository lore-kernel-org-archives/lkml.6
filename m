Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525145060; cv=none;
        d=google.com; s=arc-20160816;
        b=SMx+XaLZ5U3ch6wDKDY34cEXYoHsTRsNNYQSQvUhALQjw5D0RPjflPFux50dlWtZyj
         yLfBD716FrUZv1rxW93UzUyOaDxlL5PLiLg2PkuiOQ9iQzrfad+5iBBGeZQ2CA9Gbr70
         8ksoGHpAENV2n4TmTe87azwH5ht1VPGwfkPGg1d3vBvYtlUmE/kVcD8uq+VKOKJlJNlv
         tALmJHOX3B2vGM4EIrwbg21b/fDT3JbAatPYZviJS+k70KETArAJYCtBMHcWby5CDFUt
         ie3ycQIJFAPjNwDCVjWTzyMLAFKHv4vx88G7qsykwLtKaq1lHap64g7Jw+yHDVNlWlRg
         ajlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=BlBIdeA2fmARnwK1m5yJrHjPZaPa2zPPENFy9tyghGc=;
        b=pAp3f8VkakC/I9lrDCczNNbHEx7jwkH8+8zIyd8sJjrAohj50ml3rKLCoc1iGqfNBR
         vh8eskrkLzy/adesHbKDElO2L/z2eWDnJUiqAcj6oPWROjCv8GIIhcziNW77UW0SLB9+
         aO6VFg92YLhKTgxWSxHzqlBko9mGHCREDPONlsHM7RBDlMQQwJiGh8NSoPiInxh6qwDv
         soTovblpzhAzBDpT1n+MUYTLFLXh7+xDxAcH4OXTd7aZM+pV4vMPM3kfCA5HMKHGZD9C
         czKeIqe5+USCLltd75lAUoPL0RqzfBDWmEhZ6monC1waxcVDY4T8YhR0+uV//BBUhDB4
         AYnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZo5DsDjewcf4RsvcD2KfsQ6FACmhWd5QrIfHQkLcbPQmdTxubJGjSBxcrqknPEp3EidBhuh4g==
Message-ID: <5ae7dde3.04d61c0a.d89e8.82cb@mx.google.com>
Date: Mon, 30 Apr 2018 20:24:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.130-45-g48634b3cc04e
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/44] 4.4.131-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599200407080581115?=
X-GMAIL-MSGID: =?utf-8?q?1599230506819287912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 114 boots: 0 failed, 108 passed with 5 offline,=
 1 untried/unknown (v4.4.130-45-g48634b3cc04e)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.130-45-g48634b3cc04e/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.130-45-g48634b3cc04e/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.130-45-g48634b3cc04e
Git Commit: 48634b3cc04e40035999d583c84c07d957dc03b7
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 56 unique boards, 20 SoC families, 16 builds out of 178

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

---
For more info write to <info@kernelci.org>
