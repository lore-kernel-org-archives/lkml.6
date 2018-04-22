Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeDVKak (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 06:30:40 -0400
Received: from mout.web.de ([212.227.15.4]:48855 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeDVKah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 06:30:37 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
From: Jan Kiszka <jan.kiszka@web.de>
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
 <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
 <7bbf615b-3cdd-6bb4-6918-33e48de4225d@gmail.com>
 <a21dbee8-6e4e-9ceb-c798-dda43c2eae2d@web.de>
 <d7e94a45-5d46-0491-e5dc-2b098a11c5b1@gmail.com>
 <CAL_Jsq+MmUTMrd+jNqUB2=A-q3cCy7+QWOKG0iF6zM0hjCy3PQ@mail.gmail.com>
 <e508f3de-f21b-2510-2c6a-b810073ba1a7@web.de>
Openpgp: preference=signencrypt
Message-ID: <e06d1c0f-f60d-fc23-cd74-82f557dbc432@web.de>
Date: Sun, 22 Apr 2018 12:30:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <e508f3de-f21b-2510-2c6a-b810073ba1a7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7vblH5C5TFGc6xmr3HJRyUnPwMZadKlrESwoNnjZzEKPj8d/9cY
 6IwfeDEbkrADfHYkgqNz7IHw+iBSNEg2r8Swpgdpt66tDmUC1b1HbXJcfRp10sNexJpnsJE
 kLyguWEzMliV1aDbw+EfXEQwXcGKrpmHS9xNLJ7GxiwK0x2jWfi0zLHcdkgtWWWTr2tXGhh
 ayz1r19alzi77UvEacScQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q+LBPi8rLuk=:EpZyh6DN9vHZqcl5VMgS1g
 PzfXgd7jSD7xiiREkRtLsNxLJt7KEFP9gg0/AEfmLkNtsHLnujwcODOPY1YPEDQzkk4gHmfBm
 PTPzbEJchuDmWX40RQouMFKRvkWP71jgo+X5Bu0/uIS24ir2pt7f9hkq0tFBOjqMRYa72jhvt
 AWFNlyrOKGoWcUaRmCzwXuiGrIHCeirGlV21o7xXrlSEbI6OFbN627c7gcpa/JncpIEgwyGjl
 3wKcdRqyM22LJlu9oA6BYwCUk8NcIhi8S/JsNtUdxNhjwvP/XeN1Vh8VNUrWFOpilD2bCS0ju
 3YYCOxijSwIXzxxojavsY0/t48zpY2Js3RQc/ljh7r3x4LcCQb4Og93E+4yEhvMRJT1Grom4s
 20AngGLUd4RtgzjrFjenXnK+usrHDbPfyLCLsxB1D4b37/azxKsWr3DOA1oAvyuCvCxWLCheY
 C5ftECkFozJVhWdEYAoILYtkcu+g+vfPJebvnxJsCxGld+EDZ/jOYwZ7srtHIU9XRNoo0fFhC
 WJj/inprPK+LxS/dVstbhXHtd93/xGvXytcz+Gp9c3XpeMTGWn03rcxtv8elnevMDmD6GSkyB
 g+sCxmrWKLDR0uejnUUjPpDINSCdUNZnIToJ+AK8EuUiWX4WMqy7hWShsWS30ewveBO07JpYO
 iK3lEPHp9Y8nRA3M90bh9IaX88FMiYuY4VVw6VdTXJP5qhGn30f/y9BYN27TfyizPq78K+f5S
 ayRpmm3E6KRQvH2MaT51kE38sv5wW51WVsDqQUUotAIwpW62DMzsaEFP+jGFBBojBHb5TmzBn
 TtqFlZuDedm7yBe6ny2RMnEpc67TRNRRvjfiTh4eiw1wB0OlM4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-11 07:42, Jan Kiszka wrote:
> On 2018-04-05 23:12, Rob Herring wrote:
>> On Thu, Apr 5, 2018 at 2:28 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>> On 04/05/18 12:13, Jan Kiszka wrote:
>>>> On 2018-04-05 20:59, Frank Rowand wrote:
>>>>> Hi Jan,
>>>>>
>>>>> On 04/04/18 15:35, Jan Kiszka wrote:
>>>>>> Hi Frank,
>>>>>>
>>>>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>>>
>>>>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>>>>> (FDT) into the overlay application code.  To accomplish this,
>>>>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>>>>
>>>>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>>>>> original FDT.
>>>>>>>
>>>>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>>>>> thus responsible for freeing the unflattened devicetree.
>>>>>>>
>>>>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>>>>> or the unflattened devicetree, which could result in use after free
>>>>>>> errors.
>>>>>>>
>>>>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>>>>> overlay loader.
>>>>>>
>>>>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>>>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>>>>> device during hypervisor activation with Linux. The DT overlay is
>>>>>> created from a a template but modified prior to application to account
>>>>>> for runtime-specific parameters. See [1] for the current implementation.
>>>>>>
>>>>>> I'm now wondering how to model that scenario best with the new API.
>>>>>> Given that the loader lost ownership of the unflattened tree but the
>>>>>> modification API exist only for the that DT state, I'm not yet seeing a
>>>>>> clear solution. Should we apply the template in disabled form (status =
>>>>>> "disabled"), modify it, and then activate it while it is already applied?
>>>>>
>>>>> Thank you for the pointer to the driver - that makes it much easier to
>>>>> understand the use case and consider solutions.
>>>>>
>>>>> If you can make the changes directly on the FDT instead of on the
>>>>> expanded devicetree, then you could move to the new API.
>>>>
>>>> Are there some examples/references on how to edit FDTs in-place in the
>>>> kernel? I'd like to avoid writing the n-th FDT parser/generator.
>>>
>>> I don't know of any existing in-kernel edits of the FDT (but they might
>>> exist).  The functions to access an FDT are in libfdt, which is in
>>> scripts/dtc/libfdt/.
>>
>> Let's please not go down that route of doing FDT modifications. There
>> is little reason to other than for early boot changes. And it is much
>> easier to work on unflattened trees.
> 
> I just briefly looked into libfdt, and it would have meant building it
> into the module as there are no library functions exported by the kernel
> either. Another reason to drop that.
> 
> What's apparently working now is the pattern I initially suggested:
> Register template with status = "disabled" as overlay, then prepare and
> apply changeset that contains all needed modifications and sets the
> status to "ok". I might be leaking additional resources, but to find
> that out, I will now finally have to resolve clean unbinding of the
> generic PCI host controller [1] first.

static void free_overlay_changeset(struct overlay_changeset *ovcs)
{
	[...]
	/*
	 * TODO
	 *
	 * would like to: kfree(ovcs->overlay_tree);
	 * but can not since drivers may have pointers into this data
	 *
	 * would like to: kfree(ovcs->fdt);
	 * but can not since drivers may have pointers into this data
	 */

	kfree(ovcs);
}

What's this? I have kmemleak now jumping at me over this. Who is suppose
to plug these leaks? The caller of of_overlay_fdt_apply has no pointers
to those objects. I would say that's a regression of the new API.

Jan
