Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbeDQRJm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:09:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44937 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753875AbeDQRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:08:31 -0400
X-Google-Smtp-Source: AIpwx4+U5rFXV5YjPsBiJY6+LRYOdgyTBDrml3yd58CZhQWf5YQU5L+CQbgGyfTxJciQJB09tMyfSw==
Subject: Re: [PATCH v1 3/4] drm/tegra: plane: Add custom colorkey properties
 for older Tegra's
To: Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <cover.1523880381.git.digetx@gmail.com>
 <d78f7339de922d6a8114c73f0919534f4195f572.1523880381.git.digetx@gmail.com>
 <20180417090040.GY31310@phenom.ffwll.local>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <6ff89658-28e4-fa9f-173d-4e9a885a7962@gmail.com>
Date: Tue, 17 Apr 2018 20:08:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417090040.GY31310@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.2018 12:00, Daniel Vetter wrote:
> On Mon, Apr 16, 2018 at 03:16:27PM +0300, Dmitry Osipenko wrote:
>> Colorkey'ing allows to draw on top of overlapping planes, like for example
>> on top of a video plane. Older Tegra's have a limited colorkey'ing
>> capability such that blending features are reduced when colorkey'ing is
>> enabled. In particular dependent weighting isn't possible, meaning that
>> cursors plane can't be displayed properly. In most cases it is more useful
>> to display content on top of video overlay, sacrificing mouse cursor
>> in the area of three planes intersection with colorkey mismatch. This
>> patch adds a custom colorkey properties to primary plane and CRTC's of
>> older Tegra's, allowing userspace like Opentegra Xorg driver to implement
>> colorkey support for XVideo extension.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Since this is your own uapi, where's the userspace per
> 
> https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements

Userspace patches for colorkey and CSC utilization are in my personal github
repos for now [0][1]. The longterm plan is to get Opentegra driver / libdrm bits
of [2] to repos on freedesktop.org, which should be considered as upstream. We
have everything depending on libdrm-tegra and it is currently on hold because of
upcoming massive rework of Tegra DRM UAPI with further de-staging of jobs
submission UAPI, that reworking should start with 4.18 kernel.

For now I wanted to get initial input on the patches. Once everyone is in
agreement, I'd like to have colorkey / CSC supported by the upstream DRM driver,
so that at least grate-driver projects could utilize them right now.

> And why wo we need a tegra-private colorkey property here? I thought
> other's have been discussing this in the context of other drivers.

At least older Tegra's have limitations in regards to colorkey, like planes
blending capabilities are reduced a lot when colorkey'ing is enabled. I'm not
sure whether we'd want to have it as a generic property, because generic
userspace should be aware of those limitations, otherwise there is a good chance
to get undesirable result using colorkey. Though I'm not really sure how widely
colorkey property could be utilize by userspace and what kind of applications
that userspace could have for it, maybe having colorkey as a generic property
would be good enough after all.

I've looked up the DRI ML archive and seems the most recent colorkey-related
patches are [3]. These patches are a bit odd to me because by generic property I
assume a property that is HW-agnostic and the patchset does opposite to it.
Maybe I'm misunderstanding what is meant by 'generic' property then? Anyway I've
applied [3] and made Tegra to use that generic property, it works fine. I'll be
happy to switch to a generic property if we'll consider that it is a viable way.

[0] https://github.com/digetx/xf86-video-opentegra/commits/ckey
[1] https://github.com/digetx/libvdpau-tegra/commits/ckey
[2] https://github.com/grate-driver
[3] https://patchwork.kernel.org/patch/10117593/
