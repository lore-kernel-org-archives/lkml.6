Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755233AbeDPN3P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754889AbeDPN3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:29:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C852177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 09:29:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bean Huo <beanhuo@outlook.com>
Cc: "mingo@redhad.com" <mingo@redhad.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Bart.VanAssche@sandisk.com" <Bart.VanAssche@sandisk.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "rajatja@google.com" <rajatja@google.com>
Subject: Re: [PATCH v1 0/2] Print the request tag in Block/SCSI trace events
Message-ID: <20180416092911.7e836987@gandalf.local.home>
In-Reply-To: <MWHPR12MB1902E810C325D921CF327FAFA6B10@MWHPR12MB1902.namprd12.prod.outlook.com>
References: <MWHPR12MB1902E810C325D921CF327FAFA6B10@MWHPR12MB1902.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Apr 2018 14:41:35 +0000
Bean Huo <beanhuo@outlook.com> wrote:

> From: Bean Huo <beanhuo@micron.com>
> 
> These patches are to add the printout of the request tag in Block/SCSI trace
> events when tracing one request or command, this is very useful for tracing
> the task running status in the storage device which supports multiple command
> queue.
> 
> As for the first patch " Add tag in SCSI trace events", copied from
> Rajat Jain [1]. I am just re-sending here.
>  
> [1]https://patchwork.kernel.org/patch/6399661/
> 
> 
> Bean Huo (2):
>   trace: events: scsi: Add tag in SCSI trace events
>   trace: events: block: Add tag in block trace events

Modification of event data needs to go through the subsystem
maintainers that have the events. Please Cc the SCSI and Block
maintainers, for they are the ones that will pull in the changes. I
need to be Cc'd to make sure that they are done correctly. The content
itself is verified by the the subsystem maintainers.

-- Steve


> 
>  include/trace/events/block.h | 36 +++++++++++++++++++++++++-----------
>  include/trace/events/scsi.h  | 20 +++++++++++++-------
>  2 files changed, 38 insertions(+), 18 deletions(-)
> 
