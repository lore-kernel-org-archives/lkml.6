Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526301932; cv=none;
        d=google.com; s=arc-20160816;
        b=0V9hv3jYlNDDrx6JKAAy0huUzp+xPXD9XwvSrxxcS7Hawi/klgKb6TtqdR8T5MK12C
         5/oOL9xJU/Hp6R2/lhPL5Wxk4W0emsvxglH0QImKc5vc+8qEmmCcp2APNNHJRtsE5Zei
         iZkYQTYa2v9l+YxPmylkUweQD0d56SBrB0J+aUGgcrQy9v+hj1RMPQnIQfLbiDRstffe
         dP9Y84eRSvH8Np69AKXXC8LPVz0b7wCoqDRp7ygG/SCVyI4NLfItbjy/RbifU8nH0Jh8
         jpCWEC/w0/YbvRs1Bo1mZ0WOSBgSkraNdnKbElGbYL7GoFyrzOE2esAoLJrYD3ozR52J
         WTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=tN8/Bo99+xgJcruv/Bd3pMojo194pLyB71F7Rt6z3iQ=;
        b=pNDCC4sd7efLp7Npx1UkrvTf+1JFU7eBs8t5ajilpCL+ZXiaWIrdUDXJyQjpHvdkrM
         2LlZIfoR712hlof/QAobWfVao25LnxSSWJquNVoTybu5qUTQL3E4nWrrEuQufusp8YYT
         N5I6tD54ju+ZteV4LYdmCavdQ+N5K67cRCxvypvZDoAtssVY6FdmjQ7sNeRYgpVCpYV/
         UvDj0BW0KcOA4hsi9GF8uDHR4dXQUW/kPe/D02uoEDtS8CiuFKvUQKMBVf76qsFN9Agy
         8ILWenkIuZhSNxsZOr4CHzWtHIY9r8baUg974jz5beoLNGiwhenbmlIzDR/I1c2bR7w2
         Figw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZrDMYDZLm7jJPknTdQsoLFqQb6KtH9+ZDxjuYNdoZSjpfJdl06NSe7zhoUmqMEld+tpJKqDFA==
Message-ID: <5af984eb.1c69fb81.f8b27.ee9e@mx.google.com>
Date: Mon, 14 May 2018 05:45:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.40-63-g13b3d94ce25d
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/62] 4.14.41-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600421602414444168?=
X-GMAIL-MSGID: =?utf-8?q?1600443575682441453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 105 boots: 0 failed, 103 passed with 2 conflic=
ts (v4.14.40-63-g13b3d94ce25d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.40-63-g13b3d94ce25d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.40-63-g13b3d94ce25d/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.40-63-g13b3d94ce25d
Git Commit: 13b3d94ce25df5cc037e4d28af3ef61933281cc5
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 55 unique boards, 22 SoC families, 15 builds out of 185

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        am335x-boneblack:
            lab-collabora: new failure (last pass: v4.14.40-22-g70a593c357b=
7)

    omap2plus_defconfig:
        am335x-boneblack:
            lab-collabora: new failure (last pass: v4.14.40-22-g70a593c357b=
7)

Conflicting Boot Failures Detected: (These likely are not failures as other=
 labs are reporting PASS. Needs review.)

arm:

    omap2plus_defconfig:
        am335x-boneblack:
            lab-collabora: FAIL
            lab-baylibre-seattle: PASS

    multi_v7_defconfig:
        am335x-boneblack:
            lab-collabora: FAIL
            lab-baylibre-seattle: PASS

---
For more info write to <info@kernelci.org>
