Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeDSR7j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:59:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41876 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752976AbeDSR7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:59:37 -0400
Subject: Re: linux-next: Tree for Apr 19 (dell smbios SMM)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
References: <20180419143545.63c0c639@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6aec5528-d6f1-3e05-1ac2-6eddbd0ac64f@infradead.org>
Date: Thu, 19 Apr 2018 10:59:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419143545.63c0c639@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/18 21:35, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180418:
> 


I see some patches from about 1 month ago for this, but it was either
never fixed ... or it's back.


on x86_64:

WARNING: unmet direct dependencies detected for DELL_SMBIOS
  Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y] && (DCDBAS [=m] || DCDBAS [=m]=n) && (ACPI_WMI [=n] || ACPI_WMI [=n]=n)
  Selected by [y]:
  - DELL_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && DMI [=y] && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n) && (RFKILL [=n] || RFKILL [=n]=n) && SERIO_I8042 [=y]


drivers/platform/x86/dell-smbios-smm.o: In function `dell_smbios_smm_call':
dell-smbios-smm.c:(.text+0x7d): undefined reference to `dcdbas_smi_request'


-- 
~Randy
