Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756049AbeDXFaY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:30:24 -0400
Received: from mout.web.de ([217.72.192.78]:41513 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755952AbeDXFaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:30:12 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>
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
 <e06d1c0f-f60d-fc23-cd74-82f557dbc432@web.de>
 <7bbb9472-9c96-6012-68e6-4ec2773c7732@gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <4422f58a-ca7c-16e6-e0df-63faea50f553@web.de>
Date: Tue, 24 Apr 2018 07:29:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <7bbb9472-9c96-6012-68e6-4ec2773c7732@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CmPfvey5RNg4Dz9E6CDSVvT9p2x7VOo7cbazigfuoq1OxJCkiMC
 pgo/CGnAEmzW7j+/ev84PHv/3VYmMpJW9jZWm/yCwThVFFXMAA1rwo74MQVW8MmKMBWnFUc
 PUmdqME6OBbVhv/eJupYZe8ZUz2zkuqhItI7JRZpZDnum/eoA8TYbCVYjSQXH7I8rUB4VMI
 xmj7LqJSoIrQZzcZV9DXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L2dZHL0N0AU=:g7XbFF4L0Na74hCIzKPdYG
 J7cLp4Hz9dll1HV0KUr3SzRep7l3MrT4bI949GwJu3ZK8vHnnwIEVqFDdu+E031Q5S9fQeHqI
 1hOz9rWq5lygiYNd7mPIvR5ETyy69Rw9gURZ2zeWx2CFQhD6T3DvB49l1ZYqPwSFm16pi4Qq0
 dfPBg49q9gqbAcVt6nf9r+4EF9YIxoLxUzOvmrQaNiUVGdjnqcLfIjdmhCrMLoN+NgT4Qkcpd
 hmX2iI0FcPKzq9XQcQKA3qOEsYSgE2Mc1LECV9V6tGijvSMyp+r8i2ORNPXXYP8hZm9MyDrSy
 hOBjP5giCIkUcYuuJUwpzjKCh094xKMtr9pWHCNd3pVpTM54f6erN+evbdHqAktyrVTrJf8gC
 2Cut9Z3rywsrvjRMxI8vAeTqUDk0k7ozr7fsAiFiEHze82qjyESewzZ2Z3H4vHYBw9/DRJKes
 KlofMoGf+5kcdFdb9tDoIez9zh+8Di1s35Bn/dAF5eK0Y4hpEejmIijkL0b72kMzG2Qp16f1q
 +kv4PijMeIG6qQCQyIgZuAE/oAxKR/Y4erc3m7pEhWBnixGgx0YIq9SDRpaLKQogQGXCrojgC
 EfgdRyAthLQk4KACjMMwc0eiWCrgOxdeql9y6NGSfgSnWmLOiosz4C8gsv7dc0e+Jxa7vyJOQ
 8MLUDogO5DbM+hm67aX0dmKKVvsaz6/2RevrWqi41YmBNpRO46CFCogqMZ5n9s5kpUsLyCdT9
 ZasrVzryh+xxwwOFSZsaL11adf+7Ol8i5fQKn6ZT5p0p9t3In2djfE+5L5ms17Gdjs4iMX+Kj
 OmhCRCpxXuySwiwGbDZFE/rxKM7/6JE43AzhLURpdFWYTzzUBM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 00:38, Frank Rowand wrote:
> Hi Jan,
> 
> + Alan Tull for fpga perspective
> 
> On 04/22/18 03:30, Jan Kiszka wrote:
>> On 2018-04-11 07:42, Jan Kiszka wrote:
>>> On 2018-04-05 23:12, Rob Herring wrote:
>>>> On Thu, Apr 5, 2018 at 2:28 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>>> On 04/05/18 12:13, Jan Kiszka wrote:
>>>>>> On 2018-04-05 20:59, Frank Rowand wrote:
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> On 04/04/18 15:35, Jan Kiszka wrote:
>>>>>>>> Hi Frank,
>>>>>>>>
>>>>>>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>>>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>>>>>
>>>>>>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>>>>>>> (FDT) into the overlay application code.  To accomplish this,
>>>>>>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>>>>>>
>>>>>>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>>>>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>>>>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>>>>>>> original FDT.
>>>>>>>>>
>>>>>>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>>>>>>> thus responsible for freeing the unflattened devicetree.
>>>>>>>>>
>>>>>>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>>>>>>> or the unflattened devicetree, which could result in use after free
>>>>>>>>> errors.
>>>>>>>>>
>>>>>>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>>>>>>> overlay loader.
>>>>>>>>
>>>>>>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>>>>>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>>>>>>> device during hypervisor activation with Linux. The DT overlay is
>>>>>>>> created from a a template but modified prior to application to account
>>>>>>>> for runtime-specific parameters. See [1] for the current implementation.
>>>>>>>>
>>>>>>>> I'm now wondering how to model that scenario best with the new API.
>>>>>>>> Given that the loader lost ownership of the unflattened tree but the
>>>>>>>> modification API exist only for the that DT state, I'm not yet seeing a
>>>>>>>> clear solution. Should we apply the template in disabled form (status =
>>>>>>>> "disabled"), modify it, and then activate it while it is already applied?
>>>>>>>
>>>>>>> Thank you for the pointer to the driver - that makes it much easier to
>>>>>>> understand the use case and consider solutions.
>>>>>>>
>>>>>>> If you can make the changes directly on the FDT instead of on the
>>>>>>> expanded devicetree, then you could move to the new API.
>>>>>>
>>>>>> Are there some examples/references on how to edit FDTs in-place in the
>>>>>> kernel? I'd like to avoid writing the n-th FDT parser/generator.
>>>>>
>>>>> I don't know of any existing in-kernel edits of the FDT (but they might
>>>>> exist).  The functions to access an FDT are in libfdt, which is in
>>>>> scripts/dtc/libfdt/.
>>>>
>>>> Let's please not go down that route of doing FDT modifications. There
>>>> is little reason to other than for early boot changes. And it is much
>>>> easier to work on unflattened trees.
>>>
>>> I just briefly looked into libfdt, and it would have meant building it
>>> into the module as there are no library functions exported by the kernel
>>> either. Another reason to drop that.
>>>
>>> What's apparently working now is the pattern I initially suggested:
>>> Register template with status = "disabled" as overlay, then prepare and
>>> apply changeset that contains all needed modifications and sets the
>>> status to "ok". I might be leaking additional resources, but to find
>>> that out, I will now finally have to resolve clean unbinding of the
>>> generic PCI host controller [1] first.
>>
>> static void free_overlay_changeset(struct overlay_changeset *ovcs)
>> {
>> 	[...]
>> 	/*
>> 	 * TODO
>> 	 *
>> 	 * would like to: kfree(ovcs->overlay_tree);
>> 	 * but can not since drivers may have pointers into this data
>> 	 *
>> 	 * would like to: kfree(ovcs->fdt);
>> 	 * but can not since drivers may have pointers into this data
>> 	 */
>>
>> 	kfree(ovcs);
>> }
>>
>> What's this? I have kmemleak now jumping at me over this. Who is suppose
>> to plug these leaks? The caller of of_overlay_fdt_apply has no pointers
>> to those objects. I would say that's a regression of the new API.
> 
> The problem already existed but it was hidden.  We have never been able to
> kfree() these object because we do not know if there are any pointers into
> these objects.  The new API makes the problem visible to kmemleak.

My old code didn't have the problem because there was no one steeling
pointers to my overlay, and I was able to safely release all the
resources that I or the core on my behalf allocated. In fact, I recently
even dropped the duplication the fdt prior to unflattening it because I
got its lifecycle under control (and both kmemleak as well as kasan
confirmed this). I still consider this intentional leak a regression of
the new API.

> 
> The reason that we do not know if there are any pointers into these objects
> is that devicetree access APIs return pointers into the devicetree internal
> data structures (that is, into the overlay unflattened devicetree).  If we
> want to be able to do the kfree()s, we could change the devicetree access
> APIs.
> 
> The reason that pointers into the overlay flattened tree (ovcs->fdt) are
> also exposed is that the overlay unflattened devicetree property values
> are pointers into the overlay fdt.
> 
> ** This paragraph becomes academic (and not needed) if the fix in the next
> paragraph can be implemented. **
> I _think_ that the fdt issue __for overlays__ can be fixed somewhat easily.
> (I would want to read through the code again to make sure I'm not missing
> any issues.)  If the of_fdt_unflatten_tree() called by of_overlay_fdt_apply()
> was modified so that property values were copied into newly allocated memory
> and the live tree property pointers were set to the copy instead of to
> the value in the fdt, then I _think_ the fdt could be freed in
> of_overlay_fdt_apply() after calling of_overlay_apply().  The code that

I don't see yet how more duplicating of objects would help. Then we
would not leak the fdt or the unflattened tree on overlay destruction
but that duplicates, no?

> frees a devicetree would also have to be aware of this change -- I'm not
> sure if that leads to ugly complications or if it is easy.  The other
> question to consider is whether to make the same change to
> of_fdt_unflatten_tree() when it is called in early boot to unflatten
> the base devicetree.  Doing so would increase the memory usage of the
> live tree (we would not be able to free the base fdt after unflattening
> it because we make the fdt visible in /sys/firmware/fdt -- though
> _maybe_ that could be conditioned on CONFIG_KEXEC).
> 
> But all of the complexity of that fix is _only_ because of_overlay_apply()
> and of_overlay_remove() call overlay_notify(), passing in the overlay
> unflattened devicetree (which has pointers into the overlay fdt). Pointers
> into the overlay unflattened devicetree are then passed to the notifiers.
> (Again, I may be missing some other place that the overlay unflattened
> devicetree is made visible to other code -- a more thorough reading of
> the code is needed.) If the notifiers could be modified to accept the
> changeset list instead of of pointers to the fragments in the overlay
> unflattened devicetree then there would be no possibility of the notifiers
> keeping a pointer into the overlay fdt. I do not know if this is a

But then again the convention has to be that those changeset pointers
must not be kept - because the changeset is history after of_overlay_remove.

> practical change for the notifiers -- there are no callers of
> of_overlay_notifier_register() in the mainline kernel source. My
> recollection is that the overlay notifiers were added for the fpga
> subsystem.

We have drivers/fpga/of-fpga-region.c in-tree, and that does not seem to
store any pointers to objects, rather consumes them in-place. And I
would consider it fair to impose such a limitation on the notifier
interface.

> 
> Why is overlay_notify() the only issue related to unknown users having
> pointers into the overlay fdt?  The answer is that the overlay code
> does not directly expose the overlay unflattened devicetree (and thus
> indirectly the overlay fdt) to the live devicetree -- when the
> overlay code creates the overlay changeset, it copies from the
> overlay unflattened devicetree and overlay fdt and only exposes
> pointers to the copies.
> 
> And hopefully the issues with the overlay unflattened devicetree can
> be resolved in the same way as for the overlay fdt.

As noted above, I don't see there is a technical solution to this issue
but it's rather a matter of convention: no overlay notifier callback is
allowed to keep references to the passed tree content (unless it
reference-counts some tree nodes) beyond the execution of the callback.
With that in place, we can safely drop the backing memory IMHO.

Jan
