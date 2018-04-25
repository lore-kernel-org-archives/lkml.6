Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeDYFX0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:23:26 -0400
Received: from mout.web.de ([212.227.15.14]:48017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbeDYFXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:23:20 -0400
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
 <4483492d-37d2-63ad-6739-2cb297fa5058@gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <127c3c71-769e-32cf-72c1-6950382b8189@web.de>
Date: Wed, 25 Apr 2018 07:23:15 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <4483492d-37d2-63ad-6739-2cb297fa5058@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+I6YewQulpbx57pWJSI4/GxsvsSjazH75ke2IJ29pteRclh+qAa
 G9iiKPigTF5YK/tPB/5s2WV3oqC8CoeOJagnR1SuplZPxRLGj+cy8yXcm91vD5OTu7iaGgJ
 8IvEtre5KNKxogyt046VM3MG4vKVbMchK2LEuKrjt2yoKHCjG6bA0kqsFoUcSP7whilD75z
 l9Fo8gZ5O++O9fy3rfsTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JuYvPD9XMgc=:wf2PqqJzsCTlhlmrSYV0Of
 +M8AaWeumk+hwQq+mlZRkMFAd9MRb4s9s5BY5emt8raW2DorgIIEIW3adi8kKWQ6UKsMN0wf0
 0aMP3zo6ONVk0DEoUmFC8e/mb3OaOW5vb+5pBoBYndEBdPaoQsxkO+1rJxRngLVcx10DI5uWG
 0rzW6/AdWFCsQjLgFJKC7qHP3qnts2cnC+B0gefEaDpsX0bLRvAW+yWONEqmcoiiTtPy3WVi3
 Owd3Q5n+xlLx5wxjB12r3IwrMtDHniZDgkE2orAynLLTIfTLsVoQjSlJzs7mtg+u7Ctv9KIlf
 i6i23vopWWAwXit1NhSFMjVOCKr1eqwY7rb6bK/kLDq0XeycsMiUStuTZL4ZA/rEr+P5gqxmF
 IdYid29l+qxNuFP661detJcjRpRIJhnZ9EHauqfEZLwTLDIRg7sSAufxdZ7Yy9RkHQTodTL4k
 gOIH2dAMY/d8t8vAKxdzXVwPtvxDYTeP2oecniaiWAigT6x6QIX61R/Dr2CifGMfJ4PCshU6t
 nTkznxOT3XJ2QdQiOb/NZGqWlUo6yCUxKCxKdPK/Cp8OFekuGDwwGuUAacRO+YLJcf+RknFCb
 V+f3H0IyBipASbJs5jM6Sk8upTq9AIdT1f8B5vFl/vCgoJECACutHIl8w2VhIV7gSGLro1gjb
 GAxycmILY23EL4p3+NxzNseGWVQV7RghiKRuP6Al+qHN7k8xCiZEe1GTYaxWOgqgCOlbFhPkY
 pagnmrkBlssK0jfd6wZEsrbSXQ62mM3KWdA7m2MD+shzySIlNzu30yfurNnhrH4SxykOHRn51
 OarUfufkfKpgM1aZncA4N3S6hhqlvJ57evvo+wgRyyGUoc9sbU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 22:56, Frank Rowand wrote:
> Hi Alan,
> 
> On 04/23/18 15:38, Frank Rowand wrote:
>> Hi Jan,
>>
>> + Alan Tull for fpga perspective
>>
>> On 04/22/18 03:30, Jan Kiszka wrote:
>>> On 2018-04-11 07:42, Jan Kiszka wrote:
>>>> On 2018-04-05 23:12, Rob Herring wrote:
>>>>> On Thu, Apr 5, 2018 at 2:28 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>> On 04/05/18 12:13, Jan Kiszka wrote:
>>>>>>> On 2018-04-05 20:59, Frank Rowand wrote:
>>>>>>>> Hi Jan,
>>>>>>>>
>>>>>>>> On 04/04/18 15:35, Jan Kiszka wrote:
>>>>>>>>> Hi Frank,
>>>>>>>>>
>>>>>>>>> On 2018-03-04 01:17, frowand.list@gmail.com wrote:
>>>>>>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>>>>>>
>>>>>>>>>> Move duplicating and unflattening of an overlay flattened devicetree
>>>>>>>>>> (FDT) into the overlay application code.  To accomplish this,
>>>>>>>>>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>>>>>>>>>
>>>>>>>>>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>>>>>>>>>> code, which is thus responsible for freeing the duplicate FDT.  The
>>>>>>>>>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>>>>>>>>>> original FDT.
>>>>>>>>>>
>>>>>>>>>> The unflattened devicetree now belongs to devicetree code, which is
>>>>>>>>>> thus responsible for freeing the unflattened devicetree.
>>>>>>>>>>
>>>>>>>>>> These ownership changes prevent early freeing of the duplicated FDT
>>>>>>>>>> or the unflattened devicetree, which could result in use after free
>>>>>>>>>> errors.
>>>>>>>>>>
>>>>>>>>>> of_overlay_fdt_apply() is a private function for the anticipated
>>>>>>>>>> overlay loader.
>>>>>>>>>
>>>>>>>>> We are using of_fdt_unflatten_tree + of_overlay_apply in the
>>>>>>>>> (out-of-tree) Jailhouse loader driver in order to register a virtual
>>>>>>>>> device during hypervisor activation with Linux. The DT overlay is
>>>>>>>>> created from a a template but modified prior to application to account
>>>>>>>>> for runtime-specific parameters. See [1] for the current implementation.
>>>>>>>>>
>>>>>>>>> I'm now wondering how to model that scenario best with the new API.
>>>>>>>>> Given that the loader lost ownership of the unflattened tree but the
>>>>>>>>> modification API exist only for the that DT state, I'm not yet seeing a
>>>>>>>>> clear solution. Should we apply the template in disabled form (status =
>>>>>>>>> "disabled"), modify it, and then activate it while it is already applied?
>>>>>>>>
>>>>>>>> Thank you for the pointer to the driver - that makes it much easier to
>>>>>>>> understand the use case and consider solutions.
>>>>>>>>
>>>>>>>> If you can make the changes directly on the FDT instead of on the
>>>>>>>> expanded devicetree, then you could move to the new API.
>>>>>>>
>>>>>>> Are there some examples/references on how to edit FDTs in-place in the
>>>>>>> kernel? I'd like to avoid writing the n-th FDT parser/generator.
>>>>>>
>>>>>> I don't know of any existing in-kernel edits of the FDT (but they might
>>>>>> exist).  The functions to access an FDT are in libfdt, which is in
>>>>>> scripts/dtc/libfdt/.
>>>>>
>>>>> Let's please not go down that route of doing FDT modifications. There
>>>>> is little reason to other than for early boot changes. And it is much
>>>>> easier to work on unflattened trees.
>>>>
>>>> I just briefly looked into libfdt, and it would have meant building it
>>>> into the module as there are no library functions exported by the kernel
>>>> either. Another reason to drop that.
>>>>
>>>> What's apparently working now is the pattern I initially suggested:
>>>> Register template with status = "disabled" as overlay, then prepare and
>>>> apply changeset that contains all needed modifications and sets the
>>>> status to "ok". I might be leaking additional resources, but to find
>>>> that out, I will now finally have to resolve clean unbinding of the
>>>> generic PCI host controller [1] first.
>>>
>>> static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>> {
>>> 	[...]
>>> 	/*
>>> 	 * TODO
>>> 	 *
>>> 	 * would like to: kfree(ovcs->overlay_tree);
>>> 	 * but can not since drivers may have pointers into this data
>>> 	 *
>>> 	 * would like to: kfree(ovcs->fdt);
>>> 	 * but can not since drivers may have pointers into this data
>>> 	 */
>>>
>>> 	kfree(ovcs);
>>> }
>>>
>>> What's this? I have kmemleak now jumping at me over this. Who is suppose
>>> to plug these leaks? The caller of of_overlay_fdt_apply has no pointers
>>> to those objects. I would say that's a regression of the new API.
>>
>> The problem already existed but it was hidden.  We have never been able to
>> kfree() these object because we do not know if there are any pointers into
>> these objects.  The new API makes the problem visible to kmemleak.
>>
>> The reason that we do not know if there are any pointers into these objects
>> is that devicetree access APIs return pointers into the devicetree internal
>> data structures (that is, into the overlay unflattened devicetree).  If we
>> want to be able to do the kfree()s, we could change the devicetree access
>> APIs.
>>
>> The reason that pointers into the overlay flattened tree (ovcs->fdt) are
>> also exposed is that the overlay unflattened devicetree property values
>> are pointers into the overlay fdt.
>>
>> ** This paragraph becomes academic (and not needed) if the fix in the next
>> paragraph can be implemented. **
>> I _think_ that the fdt issue __for overlays__ can be fixed somewhat easily.
>> (I would want to read through the code again to make sure I'm not missing
>> any issues.)  If the of_fdt_unflatten_tree() called by of_overlay_fdt_apply()
>> was modified so that property values were copied into newly allocated memory
>> and the live tree property pointers were set to the copy instead of to
>> the value in the fdt, then I _think_ the fdt could be freed in
>> of_overlay_fdt_apply() after calling of_overlay_apply().  The code that
>> frees a devicetree would also have to be aware of this change -- I'm not
>> sure if that leads to ugly complications or if it is easy.  The other
>> question to consider is whether to make the same change to
>> of_fdt_unflatten_tree() when it is called in early boot to unflatten
>> the base devicetree.  Doing so would increase the memory usage of the
>> live tree (we would not be able to free the base fdt after unflattening
>> it because we make the fdt visible in /sys/firmware/fdt -- though
>> _maybe_ that could be conditioned on CONFIG_KEXEC).
> 
> Question added below this paragraph.
> 
> 
>> But all of the complexity of that fix is _only_ because of_overlay_apply()
>> and of_overlay_remove() call overlay_notify(), passing in the overlay
>> unflattened devicetree (which has pointers into the overlay fdt). Pointers
>> into the overlay unflattened devicetree are then passed to the notifiers.
>> (Again, I may be missing some other place that the overlay unflattened
>> devicetree is made visible to other code -- a more thorough reading of
>> the code is needed.) If the notifiers could be modified to accept the
>> changeset list instead of of pointers to the fragments in the overlay
>> unflattened devicetree then there would be no possibility of the notifiers
>> keeping a pointer into the overlay fdt. I do not know if this is a
>> practical change for the notifiers -- there are no callers of
>> of_overlay_notifier_register() in the mainline kernel source. My
>> recollection is that the overlay notifiers were added for the fpga
>> subsystem.
> 
> Can the fpga notifiers be changed to have the changeset as an input
> instead of having the overlay devicetree fragment and target as an
> input?
> 
> The changeset lists nodes and properties to be added, but does not
> expose any pointers to the overlay fdt or the overlay unflattened
> devicetree.  This guarantees no leakage of pointers into the overlay
> fdt or the overlay unflattened devicetree.  The changeset contains
> pointers to copies of data, but those copies are never freed (and
> thus they are yet another existing memory leak).

Also they are freed, of course: When the last reference to the node they
point to reaches 0 (e.g. triggered by of_changeset_destroy), that node
goes away and takes down remaining dead properties. I've ran through
this already. And I also made sure that my code is not triggering such
kind of leaks as well.

I agree that object management in dynamic OF code is hairy and easy to
get wrong, e.g. by passing in static objects that suddenly change
ownership, and the new owner expects dynamically allocated objects...
But that is not cured by leaking memory.

Jan
