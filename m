Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeDPQls (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:41:48 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32984 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeDPQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:41:46 -0400
X-Google-Smtp-Source: AIpwx48jbW6EHRcEGWkzti4k/ud/GqLgnXU3pwGhRtAlbzLV9BW3E6UgUc6xPtC4wBg63cYHbPFGxCoyahs+u1BUo3E=
MIME-Version: 1.0
In-Reply-To: <20180416112810.57a3f74b@gandalf.local.home>
References: <4650cbf668fd4853ad98dba834141e08@SIWEX5A.sing.micron.com> <20180416112810.57a3f74b@gandalf.local.home>
From: Rajat Jain <rajatja@google.com>
Date: Mon, 16 Apr 2018 09:41:04 -0700
Message-ID: <CACK8Z6F02C2nskv7uO20fj=Ns3OsEwJ1FjaDYaE62+jfF5QZag@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace events
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "Bart.VanAssche@sandisk.com" <Bart.VanAssche@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 8:28 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 16 Apr 2018 14:31:49 +0000
> "Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:
>
>> Print the request tag along with other information
>> while tracing a command.
>>
>> Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Rajat Jain <rajatja@google.com>

>> ---
>
> I don't see any issue with the tracing part.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> Others need to check the content.
>
> -- Steve
