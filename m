Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519995537; cv=none;
        d=google.com; s=arc-20160816;
        b=jM3Jc5OpxgAFYyDJ/n7nQngF8ktKBQNf0V97Be+ZQDLIhWFzFgogEzSc+wdQ6QgnXi
         1f7vDX4f9q3CFguhpGe/PwPr9OgWJJyihsR9AioUAm5Psncjkp4K2EwYHECM4LuGHKzL
         xJpHXatJkUe9W0fN6DmIyHj5WAlTWVsuPK1uzYkh9YbToEnejkjL6Y2iXVz2gtHbVXrw
         y8dVD3auozybZDMSUrpJTuz2aFs0YFtOovNLFGmzJuew14Y71YrU7ecjK1mu5J2R1uPX
         dddoYJ6JRn8W/lxDo4UlR0An+YL8+yoxr0NHP9VnATTQ4zBzlqOcBfk9iRkbnWKyAqWJ
         EFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=uA+QLCjsLLWZXEIpr0SNkttf/iJaXb4rSjq98scX+OQ=;
        b=oUkmOTlgiGMWtILi3XgAKv8j6e4sQBfZ/J0xvo9f0eT+UnrFIg9M34ITDsc8I2LMcX
         RgAptM0chkWnDpHVHzGOftpX3l4vUYfvDNUlDwO0r24hKH5t2rTkuNKwW7wlpQXpDHdR
         hlISI1w+9qbQ/sHlnzHS7B97lniuYBEE49XqxmPep6PQTngMKpMOqgAGACmjsJCuO2LH
         Nx3q0Yl6lTqTHOQZ33w8C2bkFK7dk1JW3jErfIBmic0B9dxmTDObnlt5J35rcIHjq9vq
         paBNDOYTo9hDrjObboji/c4NbWdIBJqzj6rnEWT/s8g2y4b1yM82YsJ/t63svJUBVwJN
         vpqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELt4A7EvJy9QsDT7d6HYNVT1hqeCV/D/gmBzErfxy/EilEWsOjEothBbURgNRJmPMFEs45275A==
Message-ID: <5a994a8f.c5171c0a.7bacb.611b@mx.google.com>
Date: Fri, 02 Mar 2018 04:58:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.97-25-g185185965d8b
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/24] 3.18.98-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593815265016315476?=
X-GMAIL-MSGID: =?utf-8?q?1593830840126892594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 33 boots: 0 failed, 33 passed (v3.18.97-25-g18=
5185965d8b)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.97-25-g185185965d8b/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.97-25-g185185965d8b/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.97-25-g185185965d8b
Git Commit: 185185965d8b441876c21a1597393f77d1b5d9ae
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 16 unique boards, 9 SoC families, 11 builds out of 167

---
For more info write to <info@kernelci.org>
