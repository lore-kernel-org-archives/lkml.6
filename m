Date: Thu, 26 Apr 2018 10:59:44 +0200
From: Greg KH <greg@kroah.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Fix overflow workaround for
 Amlogic Meson GX SoCs
Message-ID: <20180426085944.GA17265@kroah.com>
References: <1519386277-25902-1-git-send-email-narmstrong@baylibre.com>
 <3b17d17b-cf3d-be54-2462-191e4f2af653@baylibre.com>
 <20180419082751.GA23187@kroah.com>
 <8766c753-bc2c-0e54-0ac0-73acaa0e11d8@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8766c753-bc2c-0e54-0ac0-73acaa0e11d8@baylibre.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:38:08AM +0200, Neil Armstrong wrote:
> Hi Greg,
> 
> On 19/04/2018 10:27, Greg KH wrote:
> > On Thu, Apr 19, 2018 at 10:18:35AM +0200, Neil Armstrong wrote:
> >> Hi Greg,
> >>
> >> On 23/02/2018 12:44, Neil Armstrong wrote:
> >>> The Amlogic Meson GX SoCs, embedded the v2.01a controller, has been also
> >>> identified needing this workaround.
> >>> This patch adds the corresponding version to enable a single iteration for
> >>> this specific version.
> >>>
> >>> Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
> >>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>
> >> This patch is now present in linux master as commit 9c305eb442f3b371fc722ade827bbf673514123e
> >> Could it be selected for 4.14 ?
> >> The patch has been reworked to apply for 4.17 as indicated in the commit log, but the original patch will apply over 4.14.
> > 
> > I don't have any "original" patch here, I just tried applying it to
> > 4.16.y and 4.14.y and it did not work.  Can you please provide a working
> > backport?
> 
> I sent a backported version last week, any news of it ?
> 
> Message-Id: <1524128048-11086-1-git-send-email-narmstrong@baylibre.com>

Ick, for some reason I missed that in my inbox, sorry, I'll queue it up
for the next round of releases.  Thanks for reminding me.

greg k-h
