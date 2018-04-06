Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523035330; cv=none;
        d=google.com; s=arc-20160816;
        b=CsMGqfNetXj5C0bCtKg+jnvsT9epuUrz46IRNRaCCu3kBqf72E6CpBZZCnq1SieZyz
         5drneU0Hq4DsM+fgQr6q6dGWerPThsVTfJcmjSOtripBfAFl67WGjrUxC4B9L4ZetMc0
         NS2qxwfk1PsMRpIjnzxsBWvpVjJGq5nJZ9MTkshYA/HwzSSiuxbTFRUjFwCuboflIN3X
         PLL1hmDcnD+P9ymJ5sByC0jlntR4PQwZz4IZkSw/VzVF8UKgAjPCTueYiILt7wxearUI
         K/7z6Y+gUN4v0BHDnlaFjnrIk2AA/SE8w1zmYEHq3S4P5tIks8ixAFZ9pemNRXLTjqX7
         E4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=PwmRjhLD+w3+tf0uECUv0j9F8TcXirPe2mD3gYXrUt8=;
        b=zL0SVIzPvsmHyiJOaHfozPi2Qc7+KHMkcVaXUufzU35Wnt9zqXsW7idaIq0c4uRXgg
         T5Uebi88y68lHkHNipI7tdeN+MEUvxFtIDtwwnvKHrYKIC/K+kd1DVkd5OsgijLp5sJR
         GkSOMQ85f5yISrxxlJAWOj1SMxULbQWdvM7PMgM9rIKrLkrDFkE0QOdneBrZUtbAV6Wf
         6M5kYtgdhVqQG/URi9Bb86q32nBjbHnfAdtOMHPW09axjX12kIKriTqDZgLJPrg3ucCP
         ireXqEVesocgkuuOcnOt2kpuPKSWo/cmxgcs1ZXDWe7Te8TYeQKEP2M08b35SiHouZ5L
         A1kw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4/+0t8O2GeohqLIxry7FMmhpFA/tkWBzQsonGBmF/3A8nZ5VVfvFu2m9ijoQNagvS0MASv7lw==
Message-ID: <5ac7acc0.96451c0a.5afba.ffad@mx.google.com>
Date: Fri, 06 Apr 2018 10:22:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.32-68-g78c25922bb37
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/67] 4.14.33-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597004251418814512?=
X-GMAIL-MSGID: =?utf-8?q?1597018295311636583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 65 boots: 0 failed, 61 passed with 4 untried/u=
nknown (v4.14.32-68-g78c25922bb37)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.32-68-g78c25922bb37/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.32-68-g78c25922bb37/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.32-68-g78c25922bb37
Git Commit: 78c25922bb37178a70c5fd4be7163760a1abb8e2
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 32 unique boards, 14 SoC families, 15 builds out of 185

---
For more info write to <info@kernelci.org>
