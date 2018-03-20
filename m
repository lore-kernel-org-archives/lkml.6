Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCTQ3m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:29:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35894 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:29:39 -0400
X-Google-Smtp-Source: AG47ELtCYUALbxdfB18yljYaKdmuE5DY6oCO/CSirYjGc0YNZBLSmRGY9Z4yanFnMlqt6Pp/CBG78g==
Date: Tue, 20 Mar 2018 10:29:33 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] IB/nes: Eliminate duplicate barriers on
 weakly-ordered archs
Message-ID: <20180320162933.GO19744@ziepe.ca>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-6-git-send-email-okaya@codeaurora.org>
 <20180320145413.GH19744@ziepe.ca>
 <3b96019a-2b3b-374a-453e-0553fb04c0a7@codeaurora.org>
 <20180320160151.GM19744@ziepe.ca>
 <77565861-7697-699f-c876-adf36db9ab5f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77565861-7697-699f-c876-adf36db9ab5f@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 11:08:59AM -0500, Sinan Kaya wrote:

> > In this case, I strongly suspect nes really intended to say wmb()
> 
> Should I change barrier() to wmb() or leave it alone? I have no idea if 
> nes is actively being maintained or if it is EOL.

It is dead, and the HW doesn't work on 64 bit machines. Just ignore it
is my advice.

Jason
