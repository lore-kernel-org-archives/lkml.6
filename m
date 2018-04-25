Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbeDYOGE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:06:04 -0400
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:2294 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeDYOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:06:00 -0400
X-IronPort-AV: E=Sophos;i="5.49,326,1520899200";
   d="scan'208";a="11093547"
IronPort-PHdr: =?us-ascii?q?9a23=3Aa4LYmRWvb2q2vSE5DQnHNe3A3E/V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRaPvadThVPEFb/W9+hDw7KP9fy4AipYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uIhi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJqDuApXKLnnNjrjheb?=
 =?us-ascii?q?J961VHxQop099Q+pJUBasdIP7pRkDxs9nYBAcjMwOo2+bnFMl91oQGVGKXGK?=
 =?us-ascii?q?CZLafSvESQ5u01PumMYJYZuDP6K/gi/f7hk2U1lkMafamsxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhmtMBEWYMvgojQ+3mkVuCUTBIZ3upQaI86S80CJi8AYfAWI+tmrqB0z?=
 =?us-ascii?q?m/HpFMYWBGEF+MG2/yd4qYQ/cMdD6SIsh5nzwAVLihTZIh1B63uA/51bVnNO?=
 =?us-ascii?q?zU9TMctZ/4yth16PPclQso+Tx3EcudyWeNQH9wnm8SQD82xq9/q1Rnylifya?=
 =?us-ascii?q?h4n+BYFdtL6vNNUwc6M4PczuNjB9DpRA3OYsqJSEynQtW6ATA9V9cxw9gTbE?=
 =?us-ascii?q?ZgH9WtkAvO3zSlA7ALjbyHHp80/bzG33j3Ocl9z2zK1K47j1kpWsFPL3Gphr?=
 =?us-ascii?q?Zj9wjPAI7Ei1uZl6ewdaQbxyPM9XmMzWyPvEFGSgJwVaTFXXYCZkrZt9j54V?=
 =?us-ascii?q?nCT7C0BbQ6MQtL0dSCJbdSat31kVVGQ+/uONDfY2K3hmexCg+Exr2XbIX3ZW?=
 =?us-ascii?q?odwjvSCEwfngAN8naJKxI+Cj2io23AFjxuE0zgY0f2/el5snO7QVc+zxuWYE?=
 =?us-ascii?q?15y7q15hkViOSYS/MS2LIEpSggpyxuE1azxNLbEN6Apwt6fKVAetMx+lZH1W?=
 =?us-ascii?q?TXtwxnJJOvMr5tiUQDfAhtuEPuzRp3Wc18lp0GpW0rwEJSLr2V1FdaP2eU3Z?=
 =?us-ascii?q?fvN7nTMUHo8RyvYrKQ0VbbhoW44KAKvc8kpk3jsQfhLU8r93FqwpEByHeHzo?=
 =?us-ascii?q?nbBwoVF5TqWwA48AYs9OKSWTU0+46BjS4kCqKzqDKXnotzXOY=3D?=
X-IPAS-Result: =?us-ascii?q?A2DEAgCSiuBa/wHyM5BbGgEBAQEBAgEBAQEIAQEBAYMYK?=
 =?us-ascii?q?4FbKINqlHlLBnopgQ+VBTYBhEACgwkhOBQBAgEBAQEBAQIBayiCNSQBgkkBB?=
 =?us-ascii?q?SNWEAsOCgICJgICVwYNBgIBAYJYgiYNpzCCHIRYg2yCP4EJhF6CKIEMgQeBM?=
 =?us-ascii?q?oI6LodzgjQgApgDCI4/BoE0hjqEYpFcMyGBUisIAhgIIQ+CfpBqIzB6AQGPK?=
 =?us-ascii?q?AEB?=
Subject: Re: [PATCH 04/24] VFS: Add LSM hooks for filesystem context [ver #7]
To: David Howells <dhowells@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org
References: <aca7e68c-022b-47ac-c249-59e042d431e8@tycho.nsa.gov>
 <CAHC9VhQhaBNBFwAXJ4TxKO56UTcwb_LcT2G8LwNxdxOD96tTvA@mail.gmail.com>
 <152414466005.23902.12967974041384198114.stgit@warthog.procyon.org.uk>
 <152414469006.23902.8132059438921850399.stgit@warthog.procyon.org.uk>
 <3232.1524238511@warthog.procyon.org.uk>
 <703.1524583367@warthog.procyon.org.uk>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1bb08eac-517a-a07e-5e64-5771cc0c0afc@tycho.nsa.gov>
Date: Wed, 25 Apr 2018 10:07:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <703.1524583367@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 11:22 AM, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
>> Neither fsopen() nor fscontext_fs_write() appear to perform any kind of
>> up-front permission checking (DAC or MAC), although some security hooks may
>> be ultimately called to allocate structures, parse security options, etc.
>> Is there a reason not apply a may_mount() or similar check up front?
> 
> may_mount() is called by fsmount() at the moment.  It may make sense to move
> this earlier to fsopen().  Note that there's also going to be something that
> looks like:
> 
> 	fd = fspick("/mnt");
> 	fsmount(fd, "/a", MNT_NOEXEC); // ie. bind mount
> 
> or:
> 
> 	fd = fspick("/mnt");
> 	write(fd, "o intr");
> 	write(fd, "x reconfigure"); // ie. something like remount
> 	close(fd);
> 
> I guess we'd want to call may_mount() in fspick() too.  But there's also the
> possibility of using this to create a query interfact too:
> 
> 	fd = fspick("/mnt");
> 	write(fd, "q intr");
> 	read(fd, value_buffer);

My concern was that fsopen()/fscontext_fs_write() may expose attack surface (e.g. mount option parsing code) that might not be normally accessible to unprivileged userspace (i.e. gated by may_mount() and security_sb_mount()) prior to your changes.
