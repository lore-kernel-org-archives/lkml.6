Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526652355; cv=none;
        d=google.com; s=arc-20160816;
        b=g7JoeNoBLoPq9CDaqfJuWoaZ6jgo47Uclp2LjyLm+S7vPmTx2nSm+T9S24JqWDchpZ
         jhztOhV4uwxfSrdKXIVctr8pUWw0W8tL+peLqQuGNefFTzQT0Dz6Wyd0Pu4tCvhl+Yzq
         9i9e7C/KHEkL5IdzQ2KG+IWI80rvjMheyhz1fHRBbict0Gxud/nIvSS8jzu2/3wa0Z72
         6CLZBafW/VeeWCpcbmaJwMID6lcVaVSTTZnVGtM9mZI/9ofvaA+Zc2oontwTAvM78dMp
         JM/sNz3naCeMKnN2STLtofcTKN+6wgYf7cxTdJn3KH/AJAB5CeYZw5zwGYH1L7THy9l7
         TTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=gEHlDviiyZs91HF4du0HfsHu25feB8y7WnXgI4oZJMI=;
        b=wvmvp7Qw6MU4m/uSCVGA737gCovJJr611+A8XtJgKu2JCPej2IoNi/jKPeUqC4sCPw
         eQ9+AE/Wk4VgvzT07EK+8ooscCsVID1xPbYbg8tVw2pENIsllnEPalzBi7FBBHswT4nH
         PWFyAQ+G8h2D5l/oolgezdxgDzDuAgBeuCZokLEx24uwNhz+B4e9Hm6oTPzXR9zgRWmE
         DNZDNEWnr6n2WGIoeXhiQRBTdnAn9ZMoqPfhVKQXQZu0OCNxeq+5dduO233ZjFMYCJBR
         yp8C79uQ1/yeccPLeNTI8WGpvUQdNhXylH8qsNrOyzGRBK1DevHUcBYnBf8UMoYOGycW
         jWrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZrKTHn91M5DjtKtw3DBiWYPJDc6XK8MGrc5ZlcuAEPnyT1Scz2VmhKCWglrivfqvxxro8fApA==
Message-ID: <5afeddc3.1c69fb81.b0158.c73f@mx.google.com>
Date: Fri, 18 May 2018 07:05:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.100-34-g16c619d3e043
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/33] 4.9.101-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600789399035311439?=
X-GMAIL-MSGID: =?utf-8?q?1600811020934336423?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 109 boots: 0 failed, 104 passed with 5 offline =
(v4.9.100-34-g16c619d3e043)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.100-34-g16c619d3e043/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.100-34-g16c619d3e043/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.100-34-g16c619d3e043
Git Commit: 16c619d3e0437e3e655d2e87b67fec0914ad48d9
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 53 unique boards, 22 SoC families, 18 builds out of 183

Offline Platforms:

arm:

    tegra_defconfig:
        tegra30-beaver: 1 offline lab

    multi_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab
        tegra30-beaver: 1 offline lab
        zynq-zc702: 1 offline lab

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

---
For more info write to <info@kernelci.org>
