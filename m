Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeCKW6e (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:58:34 -0400
Received: from namei.org ([65.99.196.166]:52586 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932224AbeCKW6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:58:32 -0400
Date: Mon, 12 Mar 2018 09:58:02 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
cc: "Serge E. Hallyn" <serge@hallyn.com>,
        Mehmet Kayaalp <mkayaalp@cs.binghamton.edu>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        Yuqiong Sun <sunyuqiong1988@gmail.com>,
        containers <containers@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Safford <david.safford@ge.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        ima-devel <linux-ima-devel@lists.sourceforge.net>,
        Yuqiong Sun <suny@us.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/5] ima: extend clone() with IMA namespace support
In-Reply-To: <ec137677-34f8-df91-0d1c-6c6d6c951496@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1803120953310.26512@namei.org>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com> <20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com> <20170725175317.GA727@mail.hallyn.com> <1501008554.3689.30.camel@HansenPartnership.com> <20170725190406.GA1883@mail.hallyn.com>
 <1501009739.3689.33.camel@HansenPartnership.com> <1501012082.27413.17.camel@linux.vnet.ibm.com> <645db815-7773-e351-5db7-89f38cd88c3d@linux.vnet.ibm.com> <20170725204622.GA4969@mail.hallyn.com> <97839865-b0ab-8e5d-114e-0603ef2edf6f@linux.vnet.ibm.com>
 <20180309025942.GA15295@mail.hallyn.com> <ec137677-34f8-df91-0d1c-6c6d6c951496@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018, Stefan Berger wrote:

> Yuqiong is publishing a paper in this area. I believe the conference is only
> later this year.
> 
> Our goals are to enable IMA measurements, appraisal, and auditing inside a
> container using namespaces. 

This is excellent to have -- can you include this requirements analysis as 
a file Documentation/security on the next posting?

Also, if you need a public space for managing these kinds of documents, 
consider utilizing 
http://kernsec.org/wiki/index.php/Linux_Kernel_Integrity



- James
-- 
James Morris
<jmorris@namei.org>
