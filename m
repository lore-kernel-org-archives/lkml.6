Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524420216; cv=none;
        d=google.com; s=arc-20160816;
        b=sgk0QhhOpSmc7RsPTIi8ONhtGxTtUnvdxzjDsayj+HRPAvCfOvCU0LivGPzbBnbEym
         CTXfIMxGYuU8qnOFancqz6yC3sYnRb9vVWmobmZ8pQNEQBIi4bH2TSl33qcPX52gYSx2
         qf6v46TXPwdLZSnwizbLbgcGK9YJTXMbDM8TrUINmg5IVQAYh7ZHaS/X/+Yzs5jerYbn
         rHCU32gnhA+ivV/SQN8DhqrTu4xz8/v9RcLjE4MmqEytg3+nyVoo9hy2nChT2n4o0bOg
         Lvaxdov8Ot4FJC5nKNq1PudLvKLKaKGjmvWcgFuEVKXnD6M85+/VJDgVZWFzRffW2x5u
         T4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=P2Uxl8vsOFh+WIK1eeeTpdN5whoVScgsD8aJjS2QKZo=;
        b=Af0ZWEjkpN808pgqA1w5FjMI9XzgL2B8A2NhxiIZGsexGO9Ye7vlwHqEEjmGPXCVvf
         +DMDW3z4RKErZRtnLNI5pULT/rDkQdsExsTjzOlPSOeobGz6g+8Vk0pJXAbzG+zyahqX
         mUcrNBKVw8oL1ei0/NlVQhoXrBRQimZ2IsXF0Yt+45ddisCsr3/yQ7b6m1+aplXCKwzR
         D2KuBJdxCnsSk48/Pg82wvK3Pe3TfS03x/Jtp/cUPr10ZmovdNX7SNge+Eubb9jv7EN4
         8JUK/SziWDUVCV0ZLy1W0iWQh4PRzvsjlt4yndfQjfAMYD3FsbJtPNrDrGLQD6Xm9/4Q
         pwXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4+KEf3++2iXwAteV88jII3hISMP+vsozrVfDk9Nuf4Al7/XZZecAl8mQnLEYHCaBIU7Zshc0g==
Message-ID: <5adcce77.07321c0a.55fe2.0f71@mx.google.com>
Date: Sun, 22 Apr 2018 11:03:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v3.18.105-53-g5e5875c18eec
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/52] 3.18.106-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598456436335295032?=
X-GMAIL-MSGID: =?utf-8?q?1598470452798708067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 72 boots: 2 failed, 68 passed with 2 offline (=
v3.18.105-53-g5e5875c18eec)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.105-53-g5e5875c18eec/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.105-53-g5e5875c18eec/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.105-53-g5e5875c18eec
Git Commit: 5e5875c18eecc1f27e483f6027a64e62130b743f
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 35 unique boards, 13 SoC families, 15 builds out of 168

Boot Regressions Detected:

arm:

    at91_dt_defconfig:
        at91sam9m10g45ek:
            lab-free-electrons: new failure (last pass: v3.18.105-7-g715e34=
31592a)

    exynos_defconfig:
        exynos5420-arndale-octa:
            lab-baylibre-seattle: failing since 28 days (last pass: v3.18.1=
01-48-g5243764c9ee4 - first fail: v3.18.102)

Boot Failures Detected:

arm:

    at91_dt_defconfig
        at91sam9m10g45ek: 1 failed lab

    exynos_defconfig
        exynos5420-arndale-octa: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        tegra20-iris-512: 1 offline lab

---
For more info write to <info@kernelci.org>
