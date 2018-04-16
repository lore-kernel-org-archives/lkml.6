Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeDPVYw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeDPVYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:24:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD60B21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 17:24:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "beanhuo@micron.com" <beanhuo@micron.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "rajatja@google.com" <rajatja@google.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI
 trace events
Message-ID: <20180416172447.5166f854@gandalf.local.home>
In-Reply-To: <bee7c8b15b7cec3d4b1442f414e766539fac2491.camel@wdc.com>
References: <4650cbf668fd4853ad98dba834141e08@SIWEX5A.sing.micron.com>
        <bee7c8b15b7cec3d4b1442f414e766539fac2491.camel@wdc.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018 20:49:12 +0000
Bart Van Assche <Bart.VanAssche@wdc.com> wrote:

> Which tools process these strings? Has it been verified whether or not
> the tools that process these strings still work fine with this patch
> applied?

Ideally, tools shouldn't process trace event strings, but I'm sure some
do. :-/

Getting libtraceevent out as a library is a high priority of mine, and
hopefully I should get something out in a couple of months.

Ideally, tools should parse the raw data and then new fields will not
affect them.

-- Steve
