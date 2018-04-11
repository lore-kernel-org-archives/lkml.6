Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeDKOPx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:15:53 -0400
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:46655 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeDKOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:15:51 -0400
X-IronPort-AV: E=Sophos;i="5.48,436,1517875200";
   d="scan'208";a="11895477"
IronPort-PHdr: =?us-ascii?q?9a23=3Au/IE7hAU3XPkC/WqnORwUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP34r8+wAkXT6L1XgUPTWs2DsrQY07GQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDSwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDA/QdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03e?=
 =?us-ascii?q?suHgPJ0xAvEd8VrHTZrs/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUr?=
 =?us-ascii?q?Joccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHphItyyCKod7TcwvT3totSon0LEKp5?=
 =?us-ascii?q?G2cDYQxJg6wRPUduaJfJKS4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzV?=
 =?us-ascii?q?ZKsjJJktnSuXAJ0Bze8tSHReFn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZ?=
 =?us-ascii?q?oIrUvPBCr2mETyjKOOd0Uk/Pan6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0Ph?=
 =?us-ascii?q?ITU2SD/OSzzrzj/Un3QLVQif02l7HUsIvHKsQAvaO5Hw9U3Zoj6xa4FTum1s?=
 =?us-ascii?q?8YkmMdIFJKfxKHkZDlO0vSL/DgEfe/n1OsnS9wx//cJL3hDYjNLn7Ynbf6Z7?=
 =?us-ascii?q?l98UFcyBc1zdxF4pJbFKkLIOjvVU/pqNzYEhg5PhSsw+n5DtV92Z4eWWOJAq?=
 =?us-ascii?q?OAM6Pdr0WI5uQxLOmIf4IVuS/xK/wi5/7wk3A1g0QdcrOq3ZsKcnC3BO5qI0?=
 =?us-ascii?q?OHbnb2gNcBCX8AvhAiQ+zylF2CTTlTam6qX60m+zE7DJmrDZ/ZSYCwhLyNxS?=
 =?us-ascii?q?K7HppRZmBcFF+AC2vnd4KBW/0UciKdPtdhkiAYVbimU4Ih0RCutAnny7toN+?=
 =?us-ascii?q?bU4TMXuo7+1Nhv5u3TiREz+SVxD8Sazm6NUmV0kX0TSj8o06Bwv1Z9xk2A0a?=
 =?us-ascii?q?dmmfxYE8Jc5/dTXgc9L57cwPRwC8ruVQLZYteJVFGmT82iATEwSNIx3tAPb1?=
 =?us-ascii?q?9+G9q8lBDD2TSlA7sOmryVC5w77Ljc02LyJ8lj0XbG0rcuj108TstIL22mib?=
 =?us-ascii?q?Z19xLPCI7Rj0WZi6GqeLwA0yHX72eM02qPsVpDUAFsUaXKR20fZkXSrdvn/E?=
 =?us-ascii?q?POVqOhBq49PgRdzs6CL7NAasf1glVeWPfjJNPebnqzm2e1AhaI3KmMbIvxe2?=
 =?us-ascii?q?gG2iXSEk0EnB4S/XqcMgg+HCihqXrEDDNyDVLvf1/s8e5mpXO8T0871QaKb0?=
 =?us-ascii?q?1k17eu9R4VgOaTS/IX3r4epCghrDB0Fk6n393KE9qAuxZhfKJEbNM871dH0n?=
 =?us-ascii?q?jZuxZmPpy8KKBinkYefB5sskPuyhV4EItBntYrrH8w0AVyLqeYgxt9cGaj1I?=
 =?us-ascii?q?r/J7ufBmnz+BSobeaCwVjE38uQ0rwG8vslrRPmsVftXnYv72561JF12n2Q79?=
 =?us-ascii?q?2eFAcUXo/wVAM0+gJ8qrXyY2w54J3Zk2ZlMrSuu3nE1pQrHL1hgi6pYtMXFa?=
 =?us-ascii?q?SDDgK6R9UTGsyGMOU3nx2saRUeMaZZ86tibO28cP7T47KmJOZtmnqdiG1D5I?=
 =?us-ascii?q?1smhaX+zFUVv/D35FDxeqRmASASWGv3x+arsnrlNUcNnkpFW2lxH2hXdQJaw?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ChAQAiGM5a/wHyM5BcGQEBAQEBAQEBAQEBAQcBAQEBA?=
 =?us-ascii?q?YMXK4FQKINilRJFAQEBAwaBI4EPkmGBeoUOAoJQITYWAQIBAQEBAQECAWsog?=
 =?us-ascii?q?jUkAYJJAQUjBFIQCxgCAiYCAlcGAQwGAgEBgliCJA2ma4FpM4RXg26CH4EJh?=
 =?us-ascii?q?mWBDIEHgQwigmKHb4JUApdcCI4xBoEzg1qHN4cqigojByqBUisIAhgIIQ+Cf?=
 =?us-ascii?q?YIgFxGOIiMwjTcBAQ?=
Subject: Re: [PATCH v5 1/1] security: Add mechanism to safely (un)load LSMs
 after boot time
To: Sargun Dhillon <sargun@sargun.me>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Peter Dolding <oiaohm@gmail.com>,
        Igor Stoppa <igor.stoppa@huawei.com>
References: <201804090338.w393crfv005435@www262.sakura.ne.jp>
 <CAMp4zn8GOFk9EKCS9JaEsKayDZ+pLFORWBRHPaCCsN--EyvFVg@mail.gmail.com>
 <201804090525.w395P1qS044316@www262.sakura.ne.jp>
 <CAMp4zn9uc-Z4NOn_0YQ-8qgdDdJxdNA56GCWGhjEbYQBzp_pOg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9cacbdfa-d224-189b-1e79-155a81f3dcdf@tycho.nsa.gov>
Date: Wed, 11 Apr 2018 10:17:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMp4zn9uc-Z4NOn_0YQ-8qgdDdJxdNA56GCWGhjEbYQBzp_pOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 05:24 PM, Sargun Dhillon wrote:
> On Sun, Apr 8, 2018 at 10:25 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> Sargun Dhillon wrote:
>>>>   Remove SECURITY_HOOK_COUNT and "struct security_hook_list"->owner and
>>>>   the exception in randomize_layout_plugin.c because preventing module
>>>>   unloading won't work as expected.
>>>>
>>>
>>> Rather than completely removing the unloading code, might it make
>>> sense to add a BUG_ON or WARN_ON, in security_delete_hooks if
>>> allow_unload_module is false, and owner is not NULL?
>>
>> Do we need to check ->owner != NULL? Although it will be true that
>> SELinux's ->owner == NULL and LKM-based LSM module's ->owner != NULL,
>> I think we unregister SELinux before setting allow_unload_module to false.
>> Thus, rejecting delete_security_hooks() if allow_unload_module == false will
>> be sufficient. SELinux might want to call panic() if delete_security_hooks()
>> did not unregister due to allow_unload_module == false. Also,
>> allow_unload_module would be renamed to allow_unregister_module.
>>
>> By the way, please don't use BUG_ON() or WARN_ON() because syzbot would hit
>> and call panic() because syzbot runs tests with panic_on_warn == true.
> 
> I think my primary question is for the SELinux folks -- what do you
> think the behaviour should be? If allow_unload_modules /
> allow_unregister_module is set, do you want to be able to call
> security_delete_hooks? What do you think the right
> action should be if it fails?

The one that avoids breakage for existing users ;)

I personally am in favor of killing SELinux support for runtime disable aka
CONFIG_SECURITY_SELINUX_DISABLE; the only reason it exists is that Red Hat
originally insisted that bootloader configuration is too painful to modify/update on
certain platforms and therefore the selinux=0 boot parameter is insufficient
as a mechanism for disabling SELinux.

However, we can't break existing users.  Userspace should still attempt to proceed
even if runtime disable fails, just with SELinux left in permissive mode and no
policy loaded.  That generally should work, but does retain the performance overhead
of the SELinux hook function processing, unlike a real disable.

I don't think we particularly care about allow_unload_modules / allow_unregister_module
since there is no existing userspace or configurations relying on it.
