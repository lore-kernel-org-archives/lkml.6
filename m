Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970490AbeEXOo1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:44:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39822 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970477AbeEXOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:44:24 -0400
X-Google-Smtp-Source: AB8JxZquxeE318TiS1zxKGYiKf/A+hg8KHrDirr8Om2Q+h04/4AGuJLwkURq/cnClsumqeYT0SMeQQ==
Date: Thu, 24 May 2018 20:14:17 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 3.18 00/45] 3.18.110-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From: Harsh Shandilya <harsh@prjkt.io>
Message-ID: <AE7DD3E7-A563-40D9-937D-D33053C4EC52@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4OEisZF000572

On 24 May 2018 3:08:08 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>This is the start of the stable review cycle for the 3.18.110 release.
>There are 45 patches in this series, all will be posted as a response
>to this one.  If anyone has any issues with these being applied, please
>let me know.
>
>Responses should be made by Sat May 26 09:30:59 UTC 2018.
>Anything received after that time might be too late.
>
>The whole patch series can be found in one patch at:
>	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.110-rc1.gz
>or in the git tree and branch at:
>	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>linux-3.18.y
>and the diffstat can be found below.

Cleanly merges, builds and boots on the OnePlus 3T, no immediate regressions noticed. Thanks for the update!
-- 
Harsh Shandilya, PRJKT Development LLC.
