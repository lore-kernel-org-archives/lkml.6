Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeCBTlW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:41:22 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:46312 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeCBTlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:41:16 -0500
X-Google-Smtp-Source: AG47ELv0FtdvyaqyVuxE8ZUEU2w6vWVNikTPzVdZ+KM+wiG4b+Uy6uqcrF4MJDQfiz4SKKpISIxIjU6kJuECF8xaIJo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CAHC9VhSapR0jXyhonKjLVpBfPX-P4KCR7OJTasyiTQuDFYZ1Rw@mail.gmail.com>
References: <cover.1519930146.git.rgb@redhat.com> <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <20180302014101.jtfd2eeyxmvxcjpf@madcap2.tricolour.ca> <CAHC9VhQi2QC8_e1fgYr=bfTACdtpgXZubc6S18r+1+9qf6TJ8w@mail.gmail.com>
 <20180302182321.GE31400@bombadil.infradead.org> <CAHC9VhSapR0jXyhonKjLVpBfPX-P4KCR7OJTasyiTQuDFYZ1Rw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Mar 2018 14:41:13 -0500
Message-ID: <CAHC9VhSpziHOcLjmdTBPnRni7Cpac4naFeQAqNOzpwHoNDyTKw@mail.gmail.com>
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
To: Matthew Wilcox <willy@infradead.org>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, mszeredi@redhat.com, ebiederm@xmission.com,
        simo@redhat.com, jlayton@redhat.com, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, luto@kernel.org,
        trondmy@primarydata.com, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 2:25 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Mar 2, 2018 at 1:23 PM, Matthew Wilcox <willy@infradead.org> wrote:
>> On Fri, Mar 02, 2018 at 10:48:42AM -0500, Paul Moore wrote:
>>> On Thu, Mar 1, 2018 at 8:41 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
>>> > On 2018-03-01 14:41, Richard Guy Briggs wrote:
>>> FYI, I think you may have a problem with something in your outgoing
>>> mail path; I didn't receive the original patchset you are referencing
>>> and it doesn't appear in the mail archive either.
>>
>> I have those patches.  Which mail archive is missing them?
>
> The archive run by the linux-audit mailing list:
>
> * https://www.redhat.com/archives/linux-audit

After having my reply get bounced from the linux-audit list I realized
that Richard had gotten a little overzealous with the number of
recipients (note to Richard, you easily could have dropped some of
those lists/people from the To/CC line).

I was able to get in and free those patches from the moderation queue,
they should be arriving on the linux-audit list shortly.

-- 
paul moore
www.paul-moore.com
